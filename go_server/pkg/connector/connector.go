package connector

import (
	"context"
	"database/sql"
	"fmt"
	"net"
	"os"

	"cloud.google.com/go/cloudsqlconn"
	mysqldriver "github.com/go-sql-driver/mysql"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
)

func ConnectWithConnector() (*gorm.DB, error) {
	var (
		cloudSQLConnName = os.Getenv("KNITTING_SERVER_CLOUDSQL_CONN_NAME")

		dbProtocol = "tcp"
		dbHost     = os.Getenv("KNITTING_SERVER_DB_HOST")
		dbPort     = os.Getenv("KNITTING_SERVER_DB_PORT")
		dbUser     = os.Getenv("KNITTING_SERVER_DB_USER")
		dbPass     = os.Getenv("KNITTING_SERVER_DB_PASSWORD")
		dbName     = os.Getenv("KNITTING_SERVER_DB_NAME")
	)

	if cloudSQLConnName != "" {
		dbProtocol = "cloudsqlconn"

		d, err := cloudsqlconn.NewDialer(context.Background())
		if err != nil {
			return nil, fmt.Errorf("cloudsqlconn.NewDialer: %v", err)
		}

		mysqldriver.RegisterDialContext(dbProtocol,
			func(ctx context.Context, addr string) (net.Conn, error) {
				return d.Dial(ctx, cloudSQLConnName)
			})
	}

	dsn := fmt.Sprintf("%s:%s@%s(%s:%s)/%s?parseTime=True", dbUser, dbPass, dbProtocol, dbHost, dbPort, dbName)
	sqlDB, err := sql.Open("mysql", dsn)
	if err != nil {
		return nil, fmt.Errorf("sql.Open: %w", err)
	}

	db, err := gorm.Open(mysql.New(mysql.Config{
		Conn: sqlDB,
	}), &gorm.Config{
		NamingStrategy: schema.NamingStrategy{
			TablePrefix:   "",
			SingularTable: true,
		},
	})
	if err != nil {
		return nil, fmt.Errorf("gorm.Open: %w", err)
	}

	return db, nil
}
