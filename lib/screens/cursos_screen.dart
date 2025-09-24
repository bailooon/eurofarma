import 'package:eurofarma/screens/curso_detail_screen.dart';
import 'package:flutter/material.dart';

class CursosScreen extends StatefulWidget {
  final List<Map<String, String>> cursos;
  final String usuarioAtual;

  CursosScreen({required this.cursos, required this.usuarioAtual});

  @override
  _CursosScreenState createState() => _CursosScreenState();
}

class _CursosScreenState extends State<CursosScreen> {
  final List<Map<String, String>> meusCursos = [];

  void _inscreverCurso(Map<String, String> curso) {
    setState(() {
      if (!meusCursos.contains(curso)) {
        meusCursos.add(curso);
        widget.cursos.remove(curso); // remove da lista geral
      }
    });
  }

  Widget _buildCursoCard(
    Map<String, String> curso, {
    bool mostrarBotaoInscricao = true,
  }) {
    final corAmarelo = Color(0xFFFF2200);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CursoDetalheScreen(curso: curso),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
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
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(curso['descricao']!, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 8),
            Text(
              "Carga horária: ${curso['cargaHoraria']!}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (mostrarBotaoInscricao)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _inscreverCurso(curso),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Inscrever-se"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corAzulEscuro = Color(0xFF00358E);
    final corAmarelo = Color(0xFFFF2200);

    return Scaffold(
      backgroundColor: corAzulEscuro,
      appBar: AppBar(
        backgroundColor: corAmarelo,
        title: Text("Cursos Disponíveis"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Meus Cursos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            meusCursos.isEmpty
                ? Text(
                    "Você ainda não se inscreveu em nenhum curso.",
                    style: TextStyle(color: Colors.white70),
                  )
                : Column(
                    children: meusCursos
                        .map(
                          (c) =>
                              _buildCursoCard(c, mostrarBotaoInscricao: false),
                        )
                        .toList(),
                  ),
            SizedBox(height: 24),
            Text(
              "Todos os Cursos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: widget.cursos.map((c) => _buildCursoCard(c)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
