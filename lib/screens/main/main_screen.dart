import 'package:daelim/common/scaffold/app_scaffold.dart';
import 'package:daelim/routes/app_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appScreen: AppScreen.main,
      // 수정해야함
      child: Center(
        child: SizedBox(),
      ),
    );
  }
}
