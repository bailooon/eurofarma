// lib/screens/adm_vision.dart

import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importe para ter acesso às cores

class AdmVision extends StatefulWidget {
  const AdmVision({Key? key}) : super(key: key);

  @override
  _AdmVisionState createState() => _AdmVisionState();
}

class _AdmVisionState extends State<AdmVision> {
  final Color corAmarelo = const Color(0xFFFF2200);
  final Color corAzulEscuro = const Color(0xFF00358E);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Três abas para as funcionalidades
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: corAzulEscuro,
          title: Text(
            "Painel de Administração",
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: corAmarelo,
            unselectedLabelColor: Colors.white,
            indicatorColor: corAmarelo,
            tabs: const [
              Tab(icon: Icon(Icons.people), text: "Usuários"),
              Tab(icon: Icon(Icons.checklist), text: "Aprovações"),
              Tab(icon: Icon(Icons.insights), text: "Departamentos"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Conteúdo da aba "Usuários"
            Center(child: Text("Gerenciamento de Usuários")),
            // Conteúdo da aba "Aprovações"
            Center(child: Text("Rotas de Aprovação")),
            // Conteúdo da aba "Departamentos"
            Center(child: Text("Visão Geral dos Departamentos")),
          ],
        ),
      ),
    );
  }
}