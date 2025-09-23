import 'package:flutter/material.dart';
import '../models/post.dart';

class NewPostScreen extends StatefulWidget {
  final String autor;

  NewPostScreen({required this.autor});

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  void _salvarPost() {
    if (_tituloController.text.isEmpty || _descricaoController.text.isEmpty) {
      return;
    }

    final novoPost = Post(
      titulo: _tituloController.text,
      descricao: _descricaoController.text,
      autor: widget.autor,
    );

    Navigator.pop(context, novoPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova Sugestão")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: "Descrição"),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarPost,
              child: Text("Publicar"),
            )
          ],
        ),
      ),
    );
  }
}
