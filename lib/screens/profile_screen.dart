import 'package:flutter/material.dart';
import '../models/post.dart';

class ProfileScreen extends StatelessWidget {
  final String autor;
  final List<Post> posts;

  ProfileScreen({required this.autor, required this.posts});

  // Definindo a paleta de cores da tela para fácil reutilização
  final corFundoClaro = const Color.fromARGB(255, 248, 250, 255);
  final corTextoPrincipal = const Color(0xFF333333);
  final corAvatarFundo = const Color(0xFFE6E0F8);
  final corAvatarIcone = const Color(0xFF004387);
  final corCard = const Color(
    0xFFE6E0F8,
  ); // Ou um lilás bem claro: const Color(0xFFFAF9FF);

  @override
  Widget build(BuildContext context) {
    final postsDoAutor = posts.where((p) => p.autor == autor).toList();

    return Scaffold(
      backgroundColor: corFundoClaro,
      // --- Estilo da AppBar ---
      appBar: AppBar(
        title: Text(
          "Perfil de $autor",
          style: TextStyle(
            color: corTextoPrincipal,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Cor de fundo igual a da tela
        backgroundColor: corFundoClaro,
        // Cor dos ícones (como a seta de voltar)
        foregroundColor: corTextoPrincipal,
        // Remove a sombra da AppBar
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // Aumentando o padding geral
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Cabeçalho do perfil estilizado ---
            Row(
              children: [
                CircleAvatar(
                  radius: 35, // Um pouco maior
                  backgroundColor: corAvatarFundo,
                  child: Icon(Icons.person, size: 40, color: corAvatarIcone),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      autor,
                      style: TextStyle(
                        fontSize: 22, // Nome com mais destaque
                        fontWeight: FontWeight.bold,
                        color: corTextoPrincipal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Posts: ${postsDoAutor.length}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            Text(
              "Sugestões de $autor",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: corTextoPrincipal,
              ),
            ),
            const SizedBox(height: 12),

            // --- Lista de Posts com Cards estilizados ---
            Expanded(
              child:
                  postsDoAutor.isEmpty
                      ? Center(child: Text("Nenhuma sugestão encontrada."))
                      : ListView.builder(
                        itemCount: postsDoAutor.length,
                        itemBuilder: (context, index) {
                          var post = postsDoAutor[index];
                          return Card(
                            // Estilo do Card
                            color: corCard,
                            elevation: 0, // Sem sombra
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                16.0,
                              ), // Padding interno
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.titulo,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: corTextoPrincipal,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post.descricao,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                      height: 1.4, // Melhora a legibilidade
                                    ),
                                  ),
                                ],
                              ),
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
