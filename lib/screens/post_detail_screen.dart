// screens/post_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/post.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  final String usuarioAtual;
  final void Function(Post) onUpdatePost;

  const PostDetailScreen({
    Key? key,
    required this.post,
    required this.usuarioAtual,
    required this.onUpdatePost,
  }) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final Color corAmarelo = const Color(0xFFFF2200);
  final Color corAzulEscuro = const Color(0xFF00358E);
  final TextEditingController _controller = TextEditingController();

  void _toggleLike() {
    setState(() {
      if (widget.post.usuariosQueCurtiram.contains(widget.usuarioAtual)) {
        widget.post.usuariosQueCurtiram.remove(widget.usuarioAtual);
        if (widget.post.curtidas > 0) widget.post.curtidas--;
      } else {
        widget.post.usuariosQueCurtiram.add(widget.usuarioAtual);
        widget.post.curtidas++;
      }
    });
    widget.onUpdatePost(widget.post);
  }

 void _adicionarComentario() {
  final texto = _controller.text.trim();
  if (texto.isEmpty) return;

  final novoComentario = Comment(
    autor: widget.usuarioAtual,
    texto: texto,
  );

  setState(() {
    widget.post.comentarios = List.from(widget.post.comentarios)..add(novoComentario);
  });

  _controller.clear();
}


  @override
  Widget build(BuildContext context) {
    final jaCurtiu = widget.post.usuariosQueCurtiram.contains(widget.usuarioAtual);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: corAzulEscuro,
        title: Text("Detalhes do Post"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Cabeçalho
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: corAmarelo.withOpacity(0.2),
                      child: Text(
                        widget.post.autor.isNotEmpty
                            ? widget.post.autor[0].toUpperCase()
                            : "?",
                        style: TextStyle(
                            color: corAzulEscuro, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.autor,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: corAzulEscuro),
                        ),
                        Text(
                          "${widget.post.data.day.toString().padLeft(2, '0')}/${widget.post.data.month.toString().padLeft(2, '0')}/${widget.post.data.year}",
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                if (widget.post.titulo.isNotEmpty)
                  Text(
                    widget.post.titulo,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                if (widget.post.titulo.isNotEmpty) SizedBox(height: 8),
                Text(widget.post.descricao,
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
                SizedBox(height: 16),
                // Curtidas
                Row(
                  children: [
                    InkWell(
                      onTap: _toggleLike,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: jaCurtiu
                              ? corAmarelo.withOpacity(0.12)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            AnimatedScale(
                              scale: jaCurtiu ? 1.3 : 1.0,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeOutBack,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 200),
                                transitionBuilder: (child, anim) =>
                                    ScaleTransition(scale: anim, child: child),
                                child: Icon(
                                  jaCurtiu ? Icons.favorite : Icons.favorite_border,
                                  key: ValueKey<bool>(jaCurtiu),
                                  color: jaCurtiu ? Colors.pinkAccent : corAzulEscuro,
                                  size: 26,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text("${widget.post.curtidas}",
                                style: TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Divider(),
                Text("Comentários",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                ...widget.post.comentarios.map((c) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          c.autor.isNotEmpty ? c.autor[0].toUpperCase() : "?",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      title: Text(c.autor,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(c.texto),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          // Campo para adicionar comentário
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Escreva um comentário...",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _adicionarComentario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: corAzulEscuro,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
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
