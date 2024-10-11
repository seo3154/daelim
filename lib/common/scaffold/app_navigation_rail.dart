import 'package:daelim/routes/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationRail extends StatelessWidget {
  final AppScreen appScreen;

  const AppNavigationRail({
    super.key,
    required this.appScreen,
  });

  @override
  Widget build(BuildContext context) {
    final screens = List<AppScreen>.from(AppScreen.values);
    screens.removeAt(0);

    return NavigationRail(
      onDestinationSelected: (value) {
        final screen = screens[value];
        context.pushNamed(screen.name);
      },
      selectedIndex: appScreen.index - 1,
      destinations: AppScreen.values.map((e) {
        return NavigationRailDestination(
          icon: Icon(e.getIcon),
          label: Text(e.name),
        );
      }).toList(),
    );
  }
}
