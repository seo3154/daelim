import 'package:flutter/material.dart';

enum AppScreen { login, main, setting }

extension AppScreenExtension on AppScreen {
  String get toPath {
    switch (this) {
      case AppScreen.main:
        return '/main';
      case AppScreen.setting:
        return '/setting';
      case AppScreen.login:
        return '/login';
    }
  }

  IconData get getIcon {
    switch (this) {
      case AppScreen.main:
        return Icons.home;
      case AppScreen.setting:
        return Icons.settings;
      // 수정해야함
      default:
        return Icons.login;
    }
  }
}


// case AppScreen.main:
//         return Icons.home;
//       case AppScreen.setting:
//         return Icons.settings;
//       default:
//         return Icons.home;