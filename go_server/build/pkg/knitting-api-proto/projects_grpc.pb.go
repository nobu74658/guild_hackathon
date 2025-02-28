// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.5.1
// - protoc             (unknown)
// source: projects.proto

package knitting_api_proto

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.64.0 or later.
const _ = grpc.SupportPackageIsVersion9

const (
	ProjectService_GetProjects_FullMethodName   = "/api.ProjectService/GetProjects"
	ProjectService_CreateProject_FullMethodName = "/api.ProjectService/CreateProject"
	ProjectService_GetProject_FullMethodName    = "/api.ProjectService/GetProject"
	ProjectService_UpdateProject_FullMethodName = "/api.ProjectService/UpdateProject"
)

// ProjectServiceClient is the client API for ProjectService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type ProjectServiceClient interface {
	GetProjects(ctx context.Context, in *GetProjectsRequest, opts ...grpc.CallOption) (*GetProjectsResponse, error)
	CreateProject(ctx context.Context, opts ...grpc.CallOption) (grpc.ClientStreamingClient[CreateProjectRequest, Project], error)
	GetProject(ctx context.Context, in *GetProjectRequest, opts ...grpc.CallOption) (*Project, error)
	UpdateProject(ctx context.Context, in *UpdateProjectRequest, opts ...grpc.CallOption) (*Project, error)
}

type projectServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewProjectServiceClient(cc grpc.ClientConnInterface) ProjectServiceClient {
	return &projectServiceClient{cc}
}

func (c *projectServiceClient) GetProjects(ctx context.Context, in *GetProjectsRequest, opts ...grpc.CallOption) (*GetProjectsResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(GetProjectsResponse)
	err := c.cc.Invoke(ctx, ProjectService_GetProjects_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *projectServiceClient) CreateProject(ctx context.Context, opts ...grpc.CallOption) (grpc.ClientStreamingClient[CreateProjectRequest, Project], error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	stream, err := c.cc.NewStream(ctx, &ProjectService_ServiceDesc.Streams[0], ProjectService_CreateProject_FullMethodName, cOpts...)
	if err != nil {
		return nil, err
	}
	x := &grpc.GenericClientStream[CreateProjectRequest, Project]{ClientStream: stream}
	return x, nil
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type ProjectService_CreateProjectClient = grpc.ClientStreamingClient[CreateProjectRequest, Project]

func (c *projectServiceClient) GetProject(ctx context.Context, in *GetProjectRequest, opts ...grpc.CallOption) (*Project, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(Project)
	err := c.cc.Invoke(ctx, ProjectService_GetProject_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *projectServiceClient) UpdateProject(ctx context.Context, in *UpdateProjectRequest, opts ...grpc.CallOption) (*Project, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(Project)
	err := c.cc.Invoke(ctx, ProjectService_UpdateProject_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// ProjectServiceServer is the server API for ProjectService service.
// All implementations should embed UnimplementedProjectServiceServer
// for forward compatibility.
type ProjectServiceServer interface {
	GetProjects(context.Context, *GetProjectsRequest) (*GetProjectsResponse, error)
	CreateProject(grpc.ClientStreamingServer[CreateProjectRequest, Project]) error
	GetProject(context.Context, *GetProjectRequest) (*Project, error)
	UpdateProject(context.Context, *UpdateProjectRequest) (*Project, error)
}

// UnimplementedProjectServiceServer should be embedded to have
// forward compatible implementations.
//
// NOTE: this should be embedded by value instead of pointer to avoid a nil
// pointer dereference when methods are called.
type UnimplementedProjectServiceServer struct{}

func (UnimplementedProjectServiceServer) GetProjects(context.Context, *GetProjectsRequest) (*GetProjectsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetProjects not implemented")
}
func (UnimplementedProjectServiceServer) CreateProject(grpc.ClientStreamingServer[CreateProjectRequest, Project]) error {
	return status.Errorf(codes.Unimplemented, "method CreateProject not implemented")
}
func (UnimplementedProjectServiceServer) GetProject(context.Context, *GetProjectRequest) (*Project, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetProject not implemented")
}
func (UnimplementedProjectServiceServer) UpdateProject(context.Context, *UpdateProjectRequest) (*Project, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UpdateProject not implemented")
}
func (UnimplementedProjectServiceServer) testEmbeddedByValue() {}

// UnsafeProjectServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ProjectServiceServer will
// result in compilation errors.
type UnsafeProjectServiceServer interface {
	mustEmbedUnimplementedProjectServiceServer()
}

func RegisterProjectServiceServer(s grpc.ServiceRegistrar, srv ProjectServiceServer) {
	// If the following call pancis, it indicates UnimplementedProjectServiceServer was
	// embedded by pointer and is nil.  This will cause panics if an
	// unimplemented method is ever invoked, so we test this at initialization
	// time to prevent it from happening at runtime later due to I/O.
	if t, ok := srv.(interface{ testEmbeddedByValue() }); ok {
		t.testEmbeddedByValue()
	}
	s.RegisterService(&ProjectService_ServiceDesc, srv)
}

func _ProjectService_GetProjects_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetProjectsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ProjectServiceServer).GetProjects(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ProjectService_GetProjects_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ProjectServiceServer).GetProjects(ctx, req.(*GetProjectsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _ProjectService_CreateProject_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(ProjectServiceServer).CreateProject(&grpc.GenericServerStream[CreateProjectRequest, Project]{ServerStream: stream})
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type ProjectService_CreateProjectServer = grpc.ClientStreamingServer[CreateProjectRequest, Project]

func _ProjectService_GetProject_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetProjectRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ProjectServiceServer).GetProject(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ProjectService_GetProject_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ProjectServiceServer).GetProject(ctx, req.(*GetProjectRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _ProjectService_UpdateProject_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UpdateProjectRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ProjectServiceServer).UpdateProject(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: ProjectService_UpdateProject_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ProjectServiceServer).UpdateProject(ctx, req.(*UpdateProjectRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// ProjectService_ServiceDesc is the grpc.ServiceDesc for ProjectService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var ProjectService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "api.ProjectService",
	HandlerType: (*ProjectServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "GetProjects",
			Handler:    _ProjectService_GetProjects_Handler,
		},
		{
			MethodName: "GetProject",
			Handler:    _ProjectService_GetProject_Handler,
		},
		{
			MethodName: "UpdateProject",
			Handler:    _ProjectService_UpdateProject_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "CreateProject",
			Handler:       _ProjectService_CreateProject_Handler,
			ClientStreams: true,
		},
	},
	Metadata: "projects.proto",
}
