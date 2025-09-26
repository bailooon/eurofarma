import 'package:firebase_admin/firebase_admin.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

// Inicializa a aplicação Firebase.
// Substitua o 'serviceAccount' pelo caminho para a sua chave de serviço.
// A chave de serviço deve ser guardada num local seguro e não deve ser
// incluída no controlo de versão de forma pública.
// Usaremos um ficheiro 'firebase_admin_key.json' na raiz do projeto backend.
Future<FirebaseApp> initializeFirebaseApp() async {
  final serviceAccountPath = p.join(
    Directory.current.path,
    'backend', // ou a sua pasta de backend
    'firebase_admin_key.json',
  );
  
  if (!File(serviceAccountPath).existsSync()) {
    throw Exception("Ficheiro de chave de serviço do Firebase não encontrado em: $serviceAccountPath");
  }

  final serviceAccount = File(serviceAccountPath).readAsStringSync();
  
  return FirebaseAdmin.instance.initializeApp(
    AppOptions(
      serviceAccountId: 'sua_conta_de_servico_aqui', // Substitua com o ID da conta de serviço
      credential: FirebaseAdmin.instance.credential(
        type: 'service_account',
        projectId: 'o_seu_project_id', // Substitua pelo ID do seu projeto
        privateKey: '', // A chave privada será lida do ficheiro
        clientEmail: '', // O email do cliente será lido do ficheiro
      ),
    ),
  );
}

// Classe de modelo de dados para a sua sugestão
class Sugestao {
  String titulo;
  String descricao;
  String autor;

  Sugestao({required this.titulo, required this.descricao, required this.autor});

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'autor': autor,
      'timestamp': DateTime.now(),
    };
  }
}

// Função principal para demonstrar a utilização
void main() async {
  try {
    final app = await initializeFirebaseApp();
    final firestore = app.firestore();
    
    print("✅ Conectado ao Firebase com sucesso!");

    // Adicionar uma nova sugestão
    final novaSugestao = Sugestao(
      titulo: "Melhorar a experiência de utilizador",
      descricao: "Criar uma interface mais intuitiva e moderna para o feed.",
      autor: "José da Silva",
    );

    await firestore.collection('sugestoes').add(novaSugestao.toMap());
    print("💡 Sugestão adicionada com sucesso!");

    // Listar todas as sugestões
    print("\n📌 Listando todas as sugestões:");
    final snapshot = await firestore.collection('sugestoes').get();
    for (var doc in snapshot.docs) {
      print("- ${doc.id}: ${doc.data()['titulo']} (Autor: ${doc.data()['autor']})");
    }

    // Fechar a aplicação
    await app.delete();
  } catch (e) {
    print("❌ Erro ao conectar ou interagir com o Firebase: $e");
  }
}