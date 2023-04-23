import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:picauth/data/repo/hive_repo.dart';
import 'package:picauth/data/repo/hive_repo_impl.dart';
import 'package:picauth/data/services/hive_services.dart';

@singleton
class RegisterScreenVm extends ChangeNotifier {
  final HiveRepo _hiveRepo;

  RegisterScreenVm(@Named.from(HiveRepoImpl) this._hiveRepo);

  Points _tappedPoints = [];

  Points get tappedPoints => _tappedPoints;

  set tappedPoints(Points value) {
    _tappedPoints = value;
    notifyListeners();
  }

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void _checkAuth() {
    isAuthenticated = _hiveRepo.getPoints().isNotEmpty;
  }

  Future<void> addPointsToDb(Points points) async {
    await _hiveRepo.addPoints(points);
    _checkAuth();
  }
}
