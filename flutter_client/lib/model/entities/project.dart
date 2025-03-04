class Project {
  Project({
    required this.projectId,
    required this.title,
    required this.imageUrl,
    required this.colors,
  });
  final String projectId;
  final String title;
  final String imageUrl;
  final List<String> colors;
}
