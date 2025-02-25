package main

import (
	"context"
	"log"

	knitting_api_proto "github.com/nobu74658/guild_hackason/go_server/build/pkg/knitting-api-proto"
	"github.com/nobu74658/guild_hackason/go_server/pkg/connector"
	"github.com/nobu74658/guild_hackason/go_server/pkg/project"
	"github.com/nobu74658/guild_hackason/go_server/pkg/user"
	"google.golang.org/grpc"
)

func main() {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
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
}
