package project

import (
	"context"
	"fmt"

	knitting_api_proto "github.com/nobu74658/guild_hackason/go_server/build/pkg/knitting-api-proto"
	"gorm.io/gorm"
)

type Project_server struct {
	knitting_api_proto.UnimplementedProjectServiceServer
	DB *gorm.DB
}

type Project_table struct {
	Id     string `gorm:"primary_key"`
	Title  string `gorm:"type:longtext"`
	UserId string `gorm:"type:varchar(191);index:idx_user_id"`
}

func (s *Project_server) GetProjectByProjectId(ctx context.Context, in *knitting_api_proto.GetProjectByProjectIdRequest) (*knitting_api_proto.Project, error) {
	var project Project_table

	if err := s.DB.Where("id = ?", in.Id).First(&project).Error; err != nil {
		return nil, fmt.Errorf("failed to get project: %v", err)
	}

	response := &knitting_api_proto.Project{
		Id:     project.Id,
		Title:  project.Title,
		UserId: project.UserId,
	}

	return response, nil
}

func (s *Project_server) GetProjectsByUserId(ctx context.Context, in *knitting_api_proto.GetProjectsByUserIdRequest) (*knitting_api_proto.GetProjectsByUserIdResponse, error) {
	var projects []Project_table

	if err := s.DB.Where("user_id = ?", in.UserId).Find(&projects).Error; err != nil {
		return nil, fmt.Errorf("failed to get projects: %v", err)
	}

	var requiredProjects []*knitting_api_proto.Project
	for _, project := range projects {
		requiredProjects = append(requiredProjects, &knitting_api_proto.Project{
			Id:     project.Id,
			Title:  project.Title,
			UserId: project.UserId,
		})
	}

	response := &knitting_api_proto.GetProjectsByUserIdResponse{
		Projects: requiredProjects,
	}

	return response, nil
}
