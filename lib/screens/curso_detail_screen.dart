// curso_detalhe_screen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CursoDetalheScreen extends StatelessWidget {
  // Recebe os dados do curso que foi clicado
  final Map<String, String> curso;

  CursoDetalheScreen({required this.curso});

  // Função para abrir o link do YouTube
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final corAmarelo = Color(0xFFFEED01);
    final corAzulEscuro = Color(0xFF004387);

    return Scaffold(
      backgroundColor: corAmarelo,
      appBar: AppBar(
        backgroundColor: corAzulEscuro,
        title: Text(curso['titulo']!),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 255, 255, 255),
        ), // Cor da seta de voltar
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              curso['titulo']!,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Conteúdo do Curso:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: corAmarelo,
              ),
            ),
            SizedBox(height: 8),
            Text(
              curso['conteudo']!, // Usaremos um novo campo 'conteudo'
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(179, 0, 0, 0),
                height: 1.5, // Melhora a legibilidade
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.play_circle_fill,
                  color: const Color.fromARGB(255, 255, 0, 0),
                ),
                label: Text(
                  "Assistir Aula no YouTube",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  // Chama a função para abrir o link ao pressionar
                  // _launchURL(curso['youtubeLink']!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: corAzulEscuro,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
