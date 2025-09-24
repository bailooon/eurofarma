// screens/comments_screen.dart
import 'package:flutter/material.dart';
import '../models/post.dart';

class CommentsScreen extends StatefulWidget {
  final Post post;
  final String usuarioAtual;
  final void Function(Comment) onAddComentario;

  const CommentsScreen({
    Key? key,
    required this.post,
    required this.usuarioAtual,
    required this.onAddComentario,
  }) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _controller = TextEditingController();

  void _enviarComentario() {
  final texto = _controller.text.trim();
  if (texto.isEmpty) return;

  final novo = Comment(autor: widget.usuarioAtual, texto: texto);

  setState(() {
    widget.onAddComentario(novo);
    _controller.clear();
  });
}


  @override
  Widget build(BuildContext context) {
    final corAzulEscuro = const Color(0xFF00358E);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: corAzulEscuro,
        title: Text("Comentários"),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.post.comentarios.isEmpty
                ? Center(
                    child: Text(
                      "Seja o primeiro a comentar!",
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      final c = widget.post.comentarios[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            c.autor.isNotEmpty ? c.autor[0].toUpperCase() : '?',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        title: Text(
                          c.autor,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(c.texto),
                            SizedBox(height: 6),
                            Text(
                              c.formattedDate(),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: widget.post.comentarios.length,
                  ),
          ),

          // Input para novo comentário
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: "Escreva um comentário...",
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: corAzulEscuro,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 14,
                      ),
                    ),
                    onPressed: _enviarComentario,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
