import 'package:eurofarma/screens/curso_detail_screen.dart';
import 'package:eurofarma/screens/cursos_screen.dart';
import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'profile_screen.dart';
import '../models/post.dart';
import 'login_screen.dart'; 

class HomeScreen extends StatefulWidget {
  final String usuarioAtual;

  HomeScreen({required this.usuarioAtual});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Map<String, String>> meusCursos = [];

  List<Post> posts = [
    Post(
      titulo: "Sistema de Logística Inteligente",
      descricao: "Implementar IoT para monitorar estoque em tempo real.",
      autor: "João Silva",
    ),
    Post(
      titulo: "App para Saúde Corporativa",
      descricao: "Plataforma de bem-estar dos colaboradores.",
      autor: "Maria Souza",
    ),
    Post(
      titulo: "Assistente de IA para Atendimento",
      descricao: "Chatbot interno para suporte rápido.",
      autor: "Carlos Pereira",
    ),
    Post(
      titulo: "Dashboard de Análises em Tempo Real",
      descricao: "Painel interativo com métricas de performance instantâneas.",
      autor: "Ana Souza",
    ),
    Post(
      titulo: "Sistema de Reconhecimento de Imagens",
      descricao:
          "Ferramenta que identifica produtos e objetos em fotos automaticamente.",
      autor: "Lucas Martins",
    ),
    Post(
      titulo: "Automação de Processos Financeiros",
      descricao:
          "Rotinas de conciliação bancária e emissão de relatórios automatizadas.",
      autor: "Fernanda Lima",
    ),
    Post(
      titulo: "Plataforma de Treinamento Gamificado",
      descricao:
          "Cursos internos com desafios, pontos e recompensas para engajar colaboradores.",
      autor: "João Almeida",
    ),
    Post(
      titulo: "Integração com Assistentes de Voz",
      descricao:
          "Comandos por voz para acessar informações e executar tarefas corporativas.",
      autor: "Mariana Costa",
    ),
    Post(
      titulo: "App de Gestão de Projetos Colaborativos",
      descricao:
          "Organização de tarefas, prazos e equipes em um único espaço digital.",
      autor: "Rafael Silva",
    ),
    Post(
      titulo: "Sistema de Monitoramento Energético",
      descricao:
          "Ferramenta que analisa e sugere redução de consumo em tempo real.",
      autor: "Beatriz Santos",
    ),
    Post(
      titulo: "Plataforma de Feedback Instantâneo",
      descricao: "Ferramenta para coletar e analisar opiniões de clientes em tempo real.",
      autor: "Beatriz Santos",
    ),
    Post(
      titulo: "Assistente Preditivo de Vendas",
      descricao: "Sistema que sugere próximos passos com base no histórico de negociações.",
      autor: "Mariana Costa",
    ),
  ];

  // Lista de cursos recomendados
  List<Map<String, String>> cursos = [
    {
      'titulo': 'Inovação em Processos',
      'descricao': 'Aprenda a otimizar processos internos na empresa.',
      'cargaHoraria': '4h',
      'conteudo':
          'Em um mercado em constante evolução, a capacidade de inovar em processos não é mais um diferencial, mas uma necessidade para a sobrevivência e o crescimento do negócio. Este curso é um mergulho profundo nas metodologias e ferramentas que permitem redesenhar, otimizar e revolucionar os fluxos de trabalho da sua organização. Prepare-se para transformar processos tradicionais em sistemas inteligentes e eficientes, gerando mais valor para o cliente, reduzindo custos e capacitando sua equipe para liderar a transformação digital de dentro para fora.',
      'youtubeLink': 'http://youtube.com/watch?v=W-0vKtZnJk8',
    },
    {
      'titulo': 'Gestão de Projetos Ágeis',
      'descricao': 'Curso rápido de metodologias ágeis aplicadas à inovação.',
      'cargaHoraria': '6h',
      'conteudo':
          'Diga adeus aos cronogramas rígidos e às entregas que não atendem mais às necessidades do cliente. O curso de Gestão de Projetos Ágeis é a sua porta de entrada para um universo dinâmico, colaborativo e focado em resultados. Desenvolvido para líderes e equipes que buscam mais velocidade e adaptabilidade, este programa prático descomplica o universo ágil. Ao final deste curso, você estará apto a liderar projetos complexos, responder rapidamente às mudanças do mercado e entregar produtos e serviços que encantam seus clientes, garantindo o máximo de valor em cada entrega.',
      'youtubeLink': 'http://youtube.com/watch?v=W-0vKtZnJk8',
    },
    {
      'titulo': 'Design Thinking',
      'descricao': 'Crie soluções inovadoras com foco no usuário.',
      'cargaHoraria': '3h',
      'conteudo':
          'E se você pudesse resolver problemas complexos com a mesma abordagem criativa e empática de um designer? O Design Thinking é uma metodologia poderosa que coloca as pessoas no centro do processo de inovação para gerar soluções verdadeiramente desejáveis, viáveis e factíveis. Saia da teoria e venha colocar a mão na massa. Este curso é ideal para empreendedores, gestores e qualquer profissional que deseje criar produtos, serviços e experiências que as pessoas amam.',
      'youtubeLink': 'http://youtube.com/watch?v=W-0vKtZnJk8',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _inscreverCurso(Map<String, String> curso) {
    setState(() {
      if (!meusCursos.contains(curso)) {
        meusCursos.add(curso);
      }
    });
  }

  int _calcularPontosUsuario(String autor) {
    return posts
        .where((p) => p.autor == autor)
        .fold(0, (total, p) => total + p.curtidas);
  }

  String _getMedalha(int pontos) {
    if (pontos > 30) return "🥇 Ouro";
    if (pontos > 10) return "🥈 Prata";
    return "🥉 Bronze";
  }

  List<Map<String, dynamic>> _getRanking() {
    final Map<String, int> pontosPorAutor = {};
    for (var post in posts) {
      pontosPorAutor.update(
        post.autor,
        (valor) => valor + post.curtidas,
        ifAbsent: () => post.curtidas,
      );
    }

    final rankingEntries =
        pontosPorAutor.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

    final rankingTop10 =
        rankingEntries
            .take(10)
            .map((e) => {'autor': e.key, 'pontos': e.value})
            .toList();

    final jaIncluido = rankingTop10.any(
      (e) => e['autor'] == widget.usuarioAtual,
    );
    if (!jaIncluido) {
      final pontosUsuario = pontosPorAutor[widget.usuarioAtual] ?? 0;
      rankingTop10.add({'autor': widget.usuarioAtual, 'pontos': pontosUsuario});
    }

    return rankingTop10;
  }

  @override
  Widget build(BuildContext context) {
    int pontos = _calcularPontosUsuario(widget.usuarioAtual);
    String medalha = _getMedalha(pontos);
    List<Map<String, dynamic>> ranking = _getRanking();

    final corAmarelo = Color(0xFFFEED01); // amarelo vibrante
    final corAzulEscuro = Color(0xFF004387); // azul escuro

    final telas = [
      // --- Home moderna ---
      SingleChildScrollView(
        child: Container(
          color: corAmarelo,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Card de boas-vindas
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      corAzulEscuro,
                      const Color.fromARGB(255, 11, 0, 61),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events, size: 80, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      "Bem-vindo, ${widget.usuarioAtual}!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Você já acumulou:",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "$pontos pontos",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sua medalha: $medalha",
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Card do Ranking
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    Text(
                      "🏆 Ranking dos Top 10",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ranking.length,
                      itemBuilder: (context, index) {
                        final item = ranking[index];
                        final isUsuarioAtual =
                            item['autor'] == widget.usuarioAtual;

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isUsuarioAtual
                                    ? corAzulEscuro.withOpacity(0.3)
                                    : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "#${index + 1}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isUsuarioAtual
                                          ? corAzulEscuro
                                          : Colors.black,
                                ),
                              ),
                              Text(
                                item['autor'],
                                style: TextStyle(
                                  fontWeight:
                                      isUsuarioAtual ? FontWeight.bold : null,
                                  color:
                                      isUsuarioAtual
                                          ? corAzulEscuro
                                          : Colors.black,
                                ),
                              ),
                              Text(
                                "${item['pontos']} pts",
                                style: TextStyle(
                                  fontWeight:
                                      isUsuarioAtual ? FontWeight.bold : null,
                                  color:
                                      isUsuarioAtual
                                          ? corAzulEscuro
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // --- Cursos recomendados ---
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    Text(
                      "📚 Cursos recomendados para você",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cursos.length,
                      itemBuilder: (context, index) {
                        final curso = cursos[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        CursoDetalheScreen(curso: curso),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  corAzulEscuro.withOpacity(0.7),
                                  const Color.fromARGB(255, 4, 1, 49),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  curso['titulo']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  curso['descricao']!,
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Carga horária: ${curso['cargaHoraria']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // --- Feed ---
      FeedScreen(
        posts: posts,
        usuarioAtual: widget.usuarioAtual,
        onUpdatePosts: (novosPosts) {
          setState(() {
            posts = novosPosts;
          });
        },
      ),

      // --- Perfil ---
      ProfileScreen(autor: widget.usuarioAtual, posts: posts),

      // --- Cursos ---
      CursosScreen(cursos: cursos, usuarioAtual: widget.usuarioAtual),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: corAzulEscuro,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: corAmarelo,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: corAzulEscuro,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Feed"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Cursos"),
        ],
      ),
    );
  }
}