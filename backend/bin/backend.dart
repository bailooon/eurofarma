import 'package:backend/backend.dart' as backend;

import 'package:mysql_client/mysql_client.dart';

Future<void> main() async {
  // Configuração da conexão
  final conn = await MySQLConnection.createConnection(
    host: "localhost",
    port: 3306,
    userName: "app_user",
    password: "app123",
    databaseName: "faculdade_db",
  );

  await conn.connect();
  print("✅ Conectado ao MySQL!");

  // Inserindo um usuário de teste
  var resultUser = await conn.execute(
    "INSERT INTO usuarios (nome, email, perfil) VALUES (:nome, :email, :perfil)",
    {
      "nome": "João da Silva",
      "email": "joao@example.com",
      "perfil": "COLABORADOR"
    },
  );
  print("👤 Usuário inserido com ID: ${resultUser.lastInsertID}");

  // Inserindo uma proposta de teste vinculada ao usuário
  var resultProposal = await conn.execute(
    "INSERT INTO propostas (usuario_id, titulo, descricao) VALUES (:usuario_id, :titulo, :descricao)",
    {
      "usuario_id": resultUser.lastInsertID!,
      "titulo": "Sistema de Ideias Inovadoras",
      "descricao": "Criar um app para submissão e gestão de ideias dos colaboradores."
    },
  );
  print("💡 Proposta inserida com ID: ${resultProposal.lastInsertID}");

  // Listando propostas
  var rows = await conn.execute("SELECT p.id, p.titulo, u.nome AS autor FROM propostas p JOIN usuarios u ON p.usuario_id = u.id");
  for (final row in rows.rows) {
    print("📌 Proposta #${row.colByName("id")} - ${row.colByName("titulo")} (Autor: ${row.colByName("autor")})");
  }

  await conn.close();
}