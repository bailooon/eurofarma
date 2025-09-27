class Comment {
  final String autor;
  final String texto;
  final DateTime data;

  Comment({
    required this.autor,
    required this.texto,
    DateTime? data,
  }) : data = data ?? DateTime.now();

  String formattedDate() {
    final d = data;
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}";
  }
}

class Post {
  String titulo;
  String descricao;
  String autor;
  int curtidas;
  /// Conjunto de nomes/ids de usuários que curtiram (evita curtidas múltiplas)
  Set<String> usuariosQueCurtiram;
  List<Comment> comentarios;
  DateTime data;

  Post({
    required this.titulo,
    required this.descricao,
    required this.autor,
    this.curtidas = 5,
    Set<String>? usuariosQueCurtiram,
    List<Comment>? comentarios,
    DateTime? data,
  })  : usuariosQueCurtiram = usuariosQueCurtiram ?? <String>{},
        comentarios = comentarios ?? <Comment>[],
        data = data ?? DateTime.now();
}
