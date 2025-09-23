class Post {
  final String titulo;
  final String descricao;
  final String autor;
  int curtidas;
  List<String> comentarios;

  Post({
    required this.titulo,
    required this.descricao,
    required this.autor,
    this.curtidas = 0,
    List<String>? comentarios,
  }) : comentarios = comentarios ?? [];
}
