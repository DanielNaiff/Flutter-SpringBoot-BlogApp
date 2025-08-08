import 'package:blog_app_springboot/core/theme/app_pallete.dart';
import 'package:blog_app_springboot/core/utils/calculate_reading_time.dart';
import 'package:blog_app_springboot/core/utils/format_date.dart';
import 'package:blog_app_springboot/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.posterName ?? "Anônimo"}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      blog.imageData != null
                          ? Image.memory(
                            blog.imageData!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: AppPallete.greyColor,
                                ),
                          )
                          : const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: AppPallete.greyColor,
                          ),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
