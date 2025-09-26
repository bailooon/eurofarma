import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'adm_vision.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final corAmarelo = const Color(0xFFFEED01);
  final corAzulEscuro = const Color(0xFF004387);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corAmarelo,
      body: Stack(
        children: [
          //Container para o efeito de fade
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                // O centro do gradiente fica no meio do topo da tela.
                center: Alignment.topCenter,
                // O raio define o quão "largo" o efeito será.
                radius: 1.2,
                // As cores vão do branco para transparente.
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
                // Os 'stops' controlam a transição. O branco vai de 0% a 20%
                // do raio, e a transição para transparente termina em 60%.
                stops: const [0.2, 0.6],
              ),
            ),
          ),

          // O conteúdo original da tela (campos, botão) fica aqui,
          // por cima do efeito de fade.
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/logo.png', height: 60),
                  const SizedBox(height: 80),
                  TextField(
                    controller: _usuarioController,
                    style: TextStyle(color: corAzulEscuro, fontSize: 18),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "digite seu usuário",
                      hintStyle: TextStyle(
                        color: corAzulEscuro.withOpacity(0.7),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: corAzulEscuro,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: corAzulEscuro, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: corAzulEscuro, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _senhaController,
                    obscureText: true,
                    style: TextStyle(color: corAzulEscuro, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "digite sua senha",
                      hintStyle: TextStyle(
                        color: corAzulEscuro.withOpacity(0.7),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: corAzulEscuro,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: corAzulEscuro, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: corAzulEscuro, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      String usuario = _usuarioController.text.trim();
                      if (usuario.isNotEmpty) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              if (usuario.toLowerCase() == 'admin') {
                                return AdmVision();
                              } else {
                                return HomeScreen(usuarioAtual: usuario);
                              }
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: corAzulEscuro,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
