import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_social_media_flutter_ui_kit/model/post_model.dart';

class EditPostScreen extends StatefulWidget {
  final PostModel post; // Pass the full post

  const EditPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController descriptionController;
  late List<String> imageUrl;

  @override
  void initState() {
    super.initState();
    descriptionController =
        TextEditingController(text: widget.post.description);
    imageUrl = widget.post.postImages ?? []; // handle null case
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void savePost() {
    if (_formKey.currentState!.validate()) {
      // Call API or controller function here to update post
      // Example:
      // await postController.updatePost(widget.post.id, descriptionController.text, selectedImage);

      // Return true so previous screen can refresh
      Get.back(result: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Post")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Show current image if exists
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl.first,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(
                  child: Text("No Image"),
                ),
              ),
            const SizedBox(height: 16),

            // Edit description
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter description" : null,
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: savePost,
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}
