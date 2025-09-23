import 'package:flutter/material.dart';
import '../models/post.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;
  final Function(String) onAddComentario;

  CommentsScreen({required this.post, required this.onAddComentario});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _comentarioController = TextEditingController();

  void _salvarComentario() {
    if (_comentarioController.text.isEmpty) return;

    widget.onAddComentario(_comentarioController.text);

    _comentarioController.clear();
    setState(() {}); // atualizar a lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comentários")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.post.comentarios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(widget.post.comentarios[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _comentarioController,
                    decoration: InputDecoration(hintText: "Escreva um comentário..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _salvarComentario,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
