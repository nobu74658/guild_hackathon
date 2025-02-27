package main

import (
	"context"
	"log"
	"log/slog"
	"net"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"time"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	_ "github.com/joho/godotenv/autoload"
	knitting_api_proto "github.com/nobu74658/guild_hackason/go_server/build/pkg/knitting-api-proto"
	"github.com/nobu74658/guild_hackason/go_server/pkg/connector"
	"github.com/nobu74658/guild_hackason/go_server/pkg/project"
	"github.com/nobu74658/guild_hackason/go_server/pkg/user"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"google.golang.org/grpc"
)

var (
	allowedOrigins = []string{"http://localhost:3000"}
)

func main() {
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))

	ctx := context.Background()
	_, cancel := context.WithCancel(ctx)

	defer cancel()
	db, err := connector.ConnectWithConnector()
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}
	s := grpc.NewServer()
	db.AutoMigrate(
		&user.User_table{},
		&project.Project_table{},
	)
	knitting_api_proto.RegisterUserServiceServer(s, &user.User_server{DB: db})
	knitting_api_proto.RegisterProjectServiceServer(s, &project.Project_server{DB: db})

	mux := runtime.NewServeMux()

	handler := http.HandlerFunc(
		func(w http.ResponseWriter, r *http.Request) {
			origin := r.Header.Get("Origin")
			for _, allowedOrigin := range allowedOrigins {
				if origin == allowedOrigin {
					w.Header().Set("Access-Control-Allow-Origin", allowedOrigin)
					break
				}
			}
			w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
			w.Header().Set("Access-Control-Allow-Headers", "content-type, x-foobar-key")
			logger.Info("Access", "HttpVersion", r.ProtoMajor, "Content-Type", r.Header.Get("Content-Type"))
			logger.Info(r.Header.Get("Content-Type"))

			if r.Method == http.MethodOptions {
				w.WriteHeader(http.StatusOK)
				return
			}

			if r.ProtoMajor == 2 && strings.HasPrefix(
				r.Header.Get("Content-Type"), "application/grpc") {
				s.ServeHTTP(w, r)
			} else {
				mux.ServeHTTP(w, r)
			}
		},
	)

	logger.Info("Now starting server at : 443")
	http2Server := &http2.Server{}
	http1Server := &http.Server{Handler: h2c.NewHandler(handler, http2Server)}
	lis, err := net.Listen("tcp", ": 443")
	if err != nil {
		panic(err)
	}

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt)
	defer stop()
	// Start server
	go func() {
		if err := http1Server.Serve(lis); err != nil && err != http.ErrServerClosed {
			logger.Error("shutting down the server", "error", err)
		}
	}()

	// Wait for interrupt signal to gracefully shut down the server with a timeout of 10 seconds.
	<-ctx.Done()
	ctx, cancel = context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	if err := http1Server.Shutdown(ctx); err != nil {
		logger.Error("shutting down the server", "error", err)
	}
}
