import 'package:flutter/material.dart';

import '../../../core/widgets/app_drawer.dart';

/// HOME — o hub central da app.
///
/// Já tem o menu lateral ligado (ícone ☰ no topo + deslizar da esquerda).
/// O espaço do `body` é teu para construíres os cartões das features.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ligar o menu lateral. O ícone ☰ aparece sozinho no AppBar.
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text('HOME'),
        // Sem botão de voltar — a Home é o ecrã principal.
        automaticallyImplyLeading: false,
        // O ícone do menu (☰) é adicionado automaticamente porque há drawer.
      ),

      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ───────────────────────────────────────────────
              //  O teu espaço, Ana. Constrói aqui a Home:
              //
              //  - o cartão da data + próxima consulta (dados fake)
              //  - a grelha 2x2 de cartões (Daily Check, Weekly
              //    Summary, Care Team, Emergency) com as tuas
              //    ilustrações
              //
              //  Para navegar ao tocar num cartão, usa:
              //    context.push(AppRoute.dailyCheckPath)
              //  (precisas de importar go_router e o routes.dart)
              // ───────────────────────────────────────────────
              Center(child: Text('A tua Home começa aqui 🌿')),
            ],
          ),
        ),
      ),
    );
  }
}
