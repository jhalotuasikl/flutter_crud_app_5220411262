import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import 'add_post_view.dart'; // Import AddPostView

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Post> posts = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    print("HomeView initialized");
    _loadPosts();
  }

  void _loadPosts() async {
    try {
      posts = await apiService.fetchPosts();
      setState(() {});
    } catch (e) {
      print('Error loading posts: $e');
    }
  }

  void _deletePost(int id) async {
    try {
      await apiService.deletePost(id);
      setState(() {
        posts.removeWhere((post) => post.id == id);
      });
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPostView(
          onPostAdded: (Post post) {
            setState(() {
              posts.add(post); // Tambahkan postingan baru
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("HomeView build called");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddDialog,
          ),
        ],
      ),
      body: posts.isEmpty
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].title),
                  subtitle: Text(posts[index].body),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deletePost(posts[index].id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
