import 'package:flutter/material.dart';

import '../../../core/widgets/app_drawer.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('LOOKING BACK')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Center(child: Text('Journal')),
        ),
      ),
    );
  }
}
