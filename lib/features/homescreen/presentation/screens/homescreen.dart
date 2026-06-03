import 'package:breathe/core/router/routes.dart';
import 'package:breathe/features/homescreen/presentation/widgets/calendar_card.dart';
import 'package:breathe/features/homescreen/presentation/widgets/navigation_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ----------------- FUNCTIONS -----------------
  void _go(BuildContext context, String path) {
    context.push(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text('HOME'),
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CalendarCard(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedCard(
                    title: 'MY  JOURNAL',
                    asset: 'lib/assets/journal.png',
                    onTap: () => _go(context, AppRoute.journalPath),
                  ),
                  AnimatedCard(
                    title: 'MY JOURNEY',
                    asset: 'lib/assets/journey.png',
                    onTap: () => _go(context, AppRoute.summaryPath),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedCard(
                    title: 'CARE TEAM',
                    asset: 'lib/assets/care_team.png',
                    onTap: () => _go(context, AppRoute.careTeamPath),
                  ),
                  AnimatedCard(
                    title: 'EMERGENCY',
                    asset: 'lib/assets/emergency.png',
                    onTap: () => _go(context, AppRoute.emergencyPath),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
