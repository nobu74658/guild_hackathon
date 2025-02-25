package user

import (
	"context"
	"fmt"

	knitting_api_proto "github.com/nobu74658/guild_hackason/go_server/build/pkg/knitting-api-proto"
	"gorm.io/gorm"
)

type User_server struct {
	knitting_api_proto.UnimplementedUserServiceServer
	DB *gorm.DB
}

type User_table struct {
	Id          string `gorm:"primary_key"`
	DisplayName string `gorm:"type:longtext"`
	PhotoUrl    string `gorm:"type:longtext"`
}

func (s *User_server) GetUserByUserId(ctx context.Context, in *knitting_api_proto.UserRequest) (*knitting_api_proto.User, error) {
	var user User_table

	if err := s.DB.Where("id = ?", in.Id).First(&user).Error; err != nil {
		return nil, fmt.Errorf("failed to get user: %v", err)
	}

	response := &knitting_api_proto.User{
		Id:          user.Id,
		DisplayName: user.DisplayName,
		PhotoUrl:    user.PhotoUrl,
	}

	return response, nil
}
