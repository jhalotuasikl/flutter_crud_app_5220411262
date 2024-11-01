import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class AddPostView extends StatefulWidget {
  final Function(Post) onPostAdded;

  const AddPostView({Key? key, required this.onPostAdded}) : super(key: key);

  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final ApiService apiService = ApiService();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _addPost() async {
    String title = titleController.text;
    String body = bodyController.text;

    if (title.isEmpty || body.isEmpty) {
      // Tampilkan pesan error jika field kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and body cannot be empty')),
      );
      return;
    }

    Post newPost = Post(id: 0, title: title, body: body);
    try {
      Post createdPost = await apiService.createPost(newPost);
      widget.onPostAdded(createdPost); // Panggil fungsi callback
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } catch (e) {
      print('Error adding post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add post')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPost, // Panggil metode _addPost
              child: const Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}
