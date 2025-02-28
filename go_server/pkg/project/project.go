package project

import (
	"bytes"
	"context"
	"crypto/rand"
	"errors"
	"fmt"
	"io"
	"log"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"

	knitting_api_proto "github.com/nobu74658/guild_hackason/go_server/build/pkg/knitting-api-proto"
	"gorm.io/gorm"
)

type Project_server struct {
	knitting_api_proto.UnimplementedProjectServiceServer
	DB *gorm.DB
}

type Project_table struct {
	Id           string   `gorm:"primary_key"`
	UserId       string   `gorm:"type:varchar(191);index:idx_user_id"`
	Title        string   `gorm:"type:longtext"`
	ImageUrl     string   `gorm:"type:longtext"`
	Colors       []string `gorm:"serializer:json"`
	KnittingType string   `gorm:"type:longtext"`
}

func MakeRandomStr(digit uint32) (string, error) {
	const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	// 乱数を生成
	b := make([]byte, digit)
	if _, err := rand.Read(b); err != nil {
		return "", errors.New("unexpected error")
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

	// Create a multipart form request
	form := bytes.NewBuffer(nil)
	mw := multipart.NewWriter(form)

	// Add the image file to the form
	part, err := mw.CreateFormFile("image_file", "image.png")
	if err != nil {
		return nil, fmt.Errorf("failed to create form file: %v", err)
	}

	if _, err := part.Write(image_bytes); err != nil {
		return nil, fmt.Errorf("failed to write image bytes: %v", err)
	}

	// Add output dimensions if needed
	// mw.WriteField("output_width", "100")
	// mw.WriteField("output_height", "100")

	// Add available colors if provided
	for _, color := range in.Colors {
		if err := mw.WriteField("avalilable_colors_hex", color); err != nil {
			return nil, fmt.Errorf("failed to add color: %v", err)
		}
	}

	// Close the writer to finalize the form
	if err := mw.Close(); err != nil {
		return nil, fmt.Errorf("failed to close form writer: %v", err)
	}

	// Create the HTTP request
	image_api_url := "http://localhost:8000/api/convert"
	req, err := http.NewRequest("POST", image_api_url, form)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %v", err)
	}

	// Set the content type to include the multipart boundary
	req.Header.Set("Content-Type", mw.FormDataContentType())

	// Execute the request
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request: %v", err)
	}
	defer resp.Body.Close()

	// Check response status
	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("API request failed with status code: %d", resp.StatusCode)
	}

	// Read the response (converted image)
	convertedImageBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response: %v", err)
	}

	// Generate a random filename for the image
	imageFileName, err := MakeRandomStr(20)
	if err != nil {
		return nil, fmt.Errorf("failed to generate image filename: %v", err)
	}
	imageFileName = imageFileName + ".png"

	// Create images directory if it doesn't exist
	imagesDir := "images"
	if err := os.MkdirAll(imagesDir, 0755); err != nil {
		return nil, fmt.Errorf("failed to create images directory: %v", err)
	}

	// Save the image to disk
	imagePath := filepath.Join(imagesDir, imageFileName)
	if err := os.WriteFile(imagePath, convertedImageBytes, 0644); err != nil {
		return nil, fmt.Errorf("failed to save image: %v", err)
	}

	// Set the URL for the image
	imageURL := fmt.Sprintf("/images/%s", imageFileName)

	// Create a new project record
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
		ImageUrl:     imageURL,
		Colors:       in.Colors,
		KnittingType: in.KnittingType,
	}

	// Save the project to database
	if err := s.DB.Create(&new_project).Error; err != nil {
		return nil, fmt.Errorf("failed to create project: %v", err)
	}

	// Return the created project
	response := &knitting_api_proto.Project{
		Id:           new_project.Id,
		UserId:       new_project.UserId,
		Title:        new_project.Title,
		ImageUrl:     new_project.ImageUrl,
		Colors:       new_project.Colors,
		KnittingType: new_project.KnittingType,
	}

	return response, nil
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

func (s *Project_server) UpdateProject(ctx context.Context, in *knitting_api_proto.UpdateProjectRequest) (*knitting_api_proto.Project, error) {
	var project Project_table

	if err := s.DB.Where("id = ?", in.Id).First(&project).Error; err != nil {
		return nil, fmt.Errorf("failed to get project: %v", err)
	}

	project.Title = in.Title
	project.KnittingType = in.KnittingType

	if err := s.DB.Save(&project).Error; err != nil {
		return nil, fmt.Errorf("failed to update project: %v", err)
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
