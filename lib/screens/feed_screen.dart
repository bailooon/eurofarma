import 'package:flutter/material.dart';
import '../models/post.dart';
import 'new_post_screen.dart';
import 'comments_screen.dart';
import 'profile_screen.dart';

class FeedScreen extends StatefulWidget {
  final List<Post> posts;
  final String usuarioAtual;
  final Function(List<Post>) onUpdatePosts;

  FeedScreen({
    required this.posts,
    required this.usuarioAtual,
    required this.onUpdatePosts,
  });

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void _addPost(Post post) {
    final novosPosts = [post, ...widget.posts];
    widget.onUpdatePosts(novosPosts);
  }

  void _toggleCurtida(Post post) {
    setState(() {
      post.curtidas++;
    });
    widget.onUpdatePosts(widget.posts);
  }

  void _addComentario(Post post, String comentario) {
    setState(() {
      post.comentarios.add(comentario);
    });
    widget.onUpdatePosts(widget.posts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eurofarma Inova")),
      body: ListView.builder(
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          var post = widget.posts[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.titulo,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(post.descricao),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProfileScreen(autor: post.autor, posts: widget.posts),
                        ),
                      );
                    },
                    child: Text(
                      "Autor: ${post.autor}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Curtidas: ${post.curtidas}"),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () => _toggleCurtida(post),
                          ),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CommentsScreen(
                                    post: post,
                                    onAddComentario: (comentario) =>
                                        _addComentario(post, comentario),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoPost = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewPostScreen(
                autor: widget.usuarioAtual,
              ),
            ),
          );
          if (novoPost != null && novoPost is Post) {
            _addPost(novoPost);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
