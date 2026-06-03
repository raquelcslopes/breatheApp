import 'package:flutter/material.dart';

import '../../../core/widgets/app_drawer.dart';

/// JOURNAL — ecrã base, ainda por construir.
///
/// Já tem o AppBar (com botão de voltar automático, por vir de um push)
/// e o espaço do body livre para construíres a lista de entradas depois.
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('EMERGENCY')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Center(
            // O teu espaço: aqui vais construir a lista de entradas,
            // os filtros por humor e o botão de escrever.
            child: Text('Journal'),
          ),
        ),
      ),
    );
  }
}
