import 'dart:io';
import 'dart:typed_data';

import 'package:blog_app_springboot/core/theme/app_pallete.dart';
import 'package:blog_app_springboot/core/utils/pick_image.dart';
import 'package:blog_app_springboot/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleControler = TextEditingController();
  final contentControler = TextEditingController();
  List<String> selectedTopics = [];

  Uint8List? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    setState(() {
      image = pickedImage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleControler.dispose();
    contentControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(image!, fit: BoxFit.cover),
                      ),
                    ),
                  )
                  : GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: DottedBorder(
                      options: RectDottedBorderOptions(
                        color: AppPallete.borderColor,
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                      ),

                      child: Container(
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 40),
                            SizedBox(height: 15),
                            Text(
                              'Select your image',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }

                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color:
                                      selectedTopics.contains(e)
                                          ? const MaterialStatePropertyAll(
                                            AppPallete.gradient1,
                                          )
                                          : null,
                                  side:
                                      selectedTopics.contains(e)
                                          ? const BorderSide(
                                            color: AppPallete.borderColor,
                                          )
                                          : null,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(controller: titleControler, hintText: 'Blog title'),
              const SizedBox(height: 10),
              BlogEditor(controller: contentControler, hintText: 'Blog title'),
            ],
          ),
        ),
      ),
    );
  }
}
