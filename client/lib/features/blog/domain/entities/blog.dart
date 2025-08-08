import 'dart:typed_data';

class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final Uint8List imageData;
  final List<String> topics;
  final DateTime updatedAt;
  final String? posterName;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageData,
    required this.topics,
    required this.updatedAt,
    this.posterName,
  });
}
