import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class EditPostView extends StatefulWidget {
  final Post post;
  final Function onPostUpdated;

  EditPostView({required this.post, required this.onPostUpdated});

  @override
  _EditPostViewState createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  final ApiService apiService = ApiService();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post.title;
    bodyController.text = widget.post.body;
  }

  void _updatePost() async {
    Post updatedPost = Post(
        id: widget.post.id,
        title: titleController.text,
        body: bodyController.text);
    try {
      await apiService.updatePost(updatedPost);
      widget.onPostUpdated(); // Panggil fungsi untuk memperbarui daftar
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } catch (e) {
      print('Error updating post: $e'); // Log error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePost,
              child: const Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}
