import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:picauth/data/repo/hive_repo.dart';
import 'package:picauth/data/repo/hive_repo_impl.dart';
import 'package:picauth/screens/auth/auth_screen.dart';

import '../auth_reg/register_screen.dart';

@Singleton()
class HomeScreenVm extends ChangeNotifier {
  final HiveRepo _hiveRepo;

  HomeScreenVm(@Named.from(HiveRepoImpl) this._hiveRepo);

  bool _registered = false;

  bool get registered => _registered;

  set registered(bool value) {
    _registered = value;
    notifyListeners();
  }

  void checkIsRegistered() {
    registered = _hiveRepo.getPoints().isNotEmpty;
  }

  void navigateToRegScrn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  void navigateToAuthScrn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      ),
    );
  }
}
