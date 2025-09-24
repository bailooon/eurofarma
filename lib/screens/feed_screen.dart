// screens/feed_screen.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'comments_screen.dart';
import 'profile_screen.dart';
import 'post_detail_screen.dart';

enum OrdenacaoFeed { maisRecentes, maisCurtidos }

class FeedScreen extends StatefulWidget {
  final List<Post> posts;
  final String usuarioAtual;
  final void Function(List<Post>) onUpdatePosts;

  const FeedScreen({
    Key? key,
    required this.posts,
    required this.usuarioAtual,
    required this.onUpdatePosts,
  }) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final Color corAmarelo = const Color(0xFFFF2200);
  final Color corAzulEscuro = const Color(0xFF00358E);

  OrdenacaoFeed _ordenacaoAtual = OrdenacaoFeed.maisRecentes;

  List<Post> get postsOrdenados {
    List<Post> lista = List.from(widget.posts);
    if (_ordenacaoAtual == OrdenacaoFeed.maisCurtidos) {
      lista.sort((a, b) => b.curtidas.compareTo(a.curtidas));
    } else {
      lista.sort((a, b) => b.data.compareTo(a.data));
    }
    return lista;
  }

  void _toggleLike(Post post) {
    setState(() {
      if (post.usuariosQueCurtiram.contains(widget.usuarioAtual)) {
        post.usuariosQueCurtiram.remove(widget.usuarioAtual);
        if (post.curtidas > 0) post.curtidas--;
      } else {
        post.usuariosQueCurtiram.add(widget.usuarioAtual);
        post.curtidas++;
      }
    });
    widget.onUpdatePosts(widget.posts);
  }

  void _openComments(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsScreen(
          post: post,
          usuarioAtual: widget.usuarioAtual,
          onAddComentario: (Comment c) {
            setState(() {
              post.comentarios = List.from(post.comentarios)..add(c);
            });
            widget.onUpdatePosts(widget.posts);
          },
        ),
      ),
    );
  }

  void _openProfile(String autor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(autor: autor, posts: widget.posts),
      ),
    );
  }

  void _abrirPostDetalhado(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostDetailScreen(
          post: post,
          usuarioAtual: widget.usuarioAtual,
          onUpdatePost: (Post p) {
            setState(() {}); // atualiza feed
            widget.onUpdatePosts(widget.posts);
          },
        ),
      ),
    );
  }

  void _criarNovoPost() {
    String titulo = "";
    String descricao = "";
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7, // altura maior
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Novo Post",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "Título",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => titulo = v,
              ),
              SizedBox(height: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: null, // permite várias linhas
                  expands: true, // ocupa o espaço disponível
                  onChanged: (v) => descricao = v,
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (descricao.trim().isEmpty) return;
                      final novo = Post(
                        autor: widget.usuarioAtual,
                        titulo: titulo,
                        descricao: descricao,
                        curtidas: 0,
                        usuariosQueCurtiram: <String>{},
                        comentarios: [],
                        data: DateTime.now(),
                      );
                      setState(() {
                        widget.posts.insert(0, novo);
                      });
                      widget.onUpdatePosts(widget.posts);
                      Navigator.pop(context);
                    },
                    child: Text("Adicionar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentPreview(Post post) {
    if (post.comentarios.isEmpty) {
      return Text(
        "Sem comentários",
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      );
    }

    final recent = post.comentarios.reversed.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: recent.map((c) {
        return Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            "${c.autor}: ${c.texto}",
            style: TextStyle(color: Colors.grey[800], fontSize: 13),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPostCard(Post post, bool jaCurtiu) {
    return GestureDetector(
      onLongPress: () => _openProfile(post.autor),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // cabeçalho
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: corAmarelo.withOpacity(0.2),
                  child: Text(
                    post.autor.isNotEmpty ? post.autor[0].toUpperCase() : "?",
                    style: TextStyle(
                      color: corAzulEscuro,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _openProfile(post.autor),
                        child: Text(
                          post.autor,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: corAzulEscuro,
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${post.data.day.toString().padLeft(2, '0')}/${post.data.month.toString().padLeft(2, '0')}/${post.data.year}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "report", child: Text("Reportar")),
                  ],
                  onSelected: (v) {},
                ),
              ],
            ),

            SizedBox(height: 12),

            if (post.titulo.isNotEmpty)
              Text(
                post.titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

            if (post.titulo.isNotEmpty) SizedBox(height: 8),

            Text(
              post.descricao,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),

            SizedBox(height: 12),

            _buildCommentPreview(post),

            SizedBox(height: 12),

            // ações
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _toggleLike(post),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                              color: jaCurtiu
                                  ? Colors.pinkAccent
                                  : corAzulEscuro,
                              size: 22,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${post.curtidas}",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _openComments(post),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          color: corAzulEscuro,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${post.comentarios.length}",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                TextButton.icon(
                  onPressed: () => _abrirPostDetalhado(post),
                  icon: Icon(
                    Icons.open_in_new,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  label: Text(
                    "Abrir",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corAzulEscuro,
      body: Column(
        children: [
          // menu de ordenação
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  "Ordenar por:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12),
                DropdownButton<OrdenacaoFeed>(
                  dropdownColor: corAzulEscuro,
                  value: _ordenacaoAtual,
                  items: [
                    DropdownMenuItem(
                      value: OrdenacaoFeed.maisRecentes,
                      child: Text(
                        "Mais recentes",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DropdownMenuItem(
                      value: OrdenacaoFeed.maisCurtidos,
                      child: Text(
                        "Mais curtidos",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _ordenacaoAtual = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          // lista de posts
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: postsOrdenados.length,
              itemBuilder: (context, index) {
                final post = postsOrdenados[index];
                final jaCurtiu = post.usuariosQueCurtiram.contains(
                  widget.usuarioAtual,
                );
                return _buildPostCard(post, jaCurtiu);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: corAmarelo,
        onPressed: _criarNovoPost,
        child: Icon(Icons.add, color: corAzulEscuro),
      ),
    );
  }
}
