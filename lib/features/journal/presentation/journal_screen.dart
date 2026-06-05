import 'package:breathe/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_drawer.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('JOURNAL')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Center(child: Text('Journal')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.push(AppRoute.journalNewPath),
      ),
    );
  }
}
