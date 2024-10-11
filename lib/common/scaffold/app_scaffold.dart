import 'package:daelim/common/scaffold/app_navigation_rail.dart';
import 'package:daelim/routes/app_screen.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final AppScreen appScreen;
  final Widget child;

  const AppScaffold({
    super.key,
    required this.appScreen,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AppNavigationRail(appScreen: appScreen),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
