package project

import (
	"bytes"
	"context"
	"crypto/rand"
	"errors"
	"fmt"
	"log"
	"net/http"
	"net/url"

	"github.com/lib/pq"
	knitting_api_proto "github.com/nobu74658/guild_hackason/go_server/build/pkg/knitting-api-proto"
	"gorm.io/gorm"
)

type Project_server struct {
	knitting_api_proto.UnimplementedProjectServiceServer
	DB *gorm.DB
}

type Project_table struct {
	Id           string         `gorm:"primary_key"`
	UserId       string         `gorm:"type:varchar(191);index:idx_user_id"`
	Title        string         `gorm:"type:longtext"`
	ImageUrl     string         `gorm:"type:longtext"`
	Colors       pq.StringArray `gorm:"type:text[]"`
	KnittingType string         `gorm:"type:longtext"`
}

func MakeRandomStr(digit uint32) (string, error) {
	const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	// 乱数を生成
	b := make([]byte, digit)
	if _, err := rand.Read(b); err != nil {
		return "", errors.New("unexpected error...")
	}

	// letters からランダムに取り出して文字列を生成
	var result string
	for _, v := range b {
		// index が letters の長さに収まるように調整
		result += string(letters[int(v)%len(letters)])
	}
	return result, nil
}

func (s *Project_server) GetProjects(ctx context.Context, in *knitting_api_proto.GetProjectsRequest) (*knitting_api_proto.GetProjectsResponse, error) {
	var projects []Project_table

	if err := s.DB.Where("user_id = ?", in.UserId).Find(&projects).Error; err != nil {
		return nil, fmt.Errorf("failed to get projects: %v", err)
	}

	var requiredProjects []*knitting_api_proto.Project
	for _, project := range projects {
		requiredProjects = append(requiredProjects, &knitting_api_proto.Project{
			Id:           project.Id,
			UserId:       project.UserId,
			Title:        project.Title,
			ImageUrl:     project.ImageUrl,
			Colors:       project.Colors,
			KnittingType: project.KnittingType,
		})
	}

	response := &knitting_api_proto.GetProjectsResponse{
		Projects: requiredProjects,
	}

	return response, nil
}

func (s *Project_server) CreateProject(ctx context.Context, in *knitting_api_proto.CreateProjectRequest) (*knitting_api_proto.Project, error) {
	image_bytes := in.Image

	image_api_url := "http://localhost:8000/api/convert"
	form := url.Values{}
	form.Add("image_file")
	req, err := http.NewRequest(
		"POST",
		image_api_url,
		bytes.NewBuffer(image_bytes)
	)

	new_project := Project_table{
		Id: func() string {
			id, err := MakeRandomStr(10)
			if err != nil {
				log.Fatalf("failed to make random string: %v", err)
			}
			return id
		}(),
		UserId:       in.UserId,
		Title:        in.Title,
		Colors:       in.Colors,
		KnittingType: in.KnittingType,
	}
}

func (s *Project_server) GetProject(ctx context.Context, in *knitting_api_proto.GetProjectRequest) (*knitting_api_proto.Project, error) {
	var project Project_table

	if err := s.DB.Where("id = ?", in.Id).First(&project).Error; err != nil {
		return nil, fmt.Errorf("failed to get project: %v", err)
	}

	response := &knitting_api_proto.Project{
		Id:           project.Id,
		UserId:       project.UserId,
		Title:        project.Title,
		ImageUrl:     project.ImageUrl,
		Colors:       project.Colors,
		KnittingType: project.KnittingType,
	}

	return response, nil
}
