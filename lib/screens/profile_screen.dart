import 'package:flutter/material.dart';
import '../models/post.dart';

class ProfileScreen extends StatelessWidget {
  final String autor;
  final List<Post> posts;

  ProfileScreen({required this.autor, required this.posts});

  @override
  Widget build(BuildContext context) {
    final postsDoAutor = posts.where((p) => p.autor == autor).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Perfil de $autor")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho do perfil
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 40),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      autor,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text("Posts: ${postsDoAutor.length}"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            Text("Sugestões de $autor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            Expanded(
              child: postsDoAutor.isEmpty
                  ? Center(child: Text("Nenhum post ainda"))
                  : ListView.builder(
                      itemCount: postsDoAutor.length,
                      itemBuilder: (context, index) {
                        var post = postsDoAutor[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(post.titulo),
                            subtitle: Text(post.descricao),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
