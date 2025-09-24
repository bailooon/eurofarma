// cursos_screen.dart

import 'package:eurofarma/screens/curso_detail_screen.dart';
import 'package:flutter/material.dart';
import 'curso_detail_screen.dart'; // Importe a nova tela

class CursosScreen extends StatelessWidget {
  final List<Map<String, String>> cursos;

  CursosScreen({required this.cursos});

  @override
  Widget build(BuildContext context) {
    final corAmarelo = Color(0xFFFF2200);
    final corAzulEscuro = Color(0xFF00358E);

    return Scaffold(
      backgroundColor: corAzulEscuro,
      appBar: AppBar(
        backgroundColor: corAmarelo,
        title: Text("Cursos Disponíveis"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: cursos.length,
          itemBuilder: (context, index) {
            final curso = cursos[index];
            return InkWell( // 1. Widget para tornar a área clicável
              onTap: () {
                // 2. Ação de navegação ao clicar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CursoDetalheScreen(curso: curso),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16), // Para o efeito de clique
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [corAmarelo.withOpacity(0.8), Colors.orangeAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      curso['titulo']!,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      curso['descricao']!,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Carga horária: ${curso['cargaHoraria']!}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}