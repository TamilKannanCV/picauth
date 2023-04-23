import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:picauth/data/repo/hive_repo.dart';
import 'package:picauth/data/repo/hive_repo_impl.dart';
import 'package:picauth/data/services/hive_services.dart';

@singleton
class AuthScreenVm extends ChangeNotifier {
  final HiveRepo _hiveRepo;
  AuthScreenVm(@Named.from(HiveRepoImpl) this._hiveRepo);

  Points _tappedPoints = [];
  Points get tappedPoints => _tappedPoints;

  set tappedPoints(Points value) {
    _tappedPoints = value;
    notifyListeners();
  }

  Points _getPointsFromDb() {
    return _hiveRepo.getPoints();
  }

  bool isAuthenticated() {
    return _hiveRepo.getPoints().isNotEmpty;
  }

  bool validate(Points points) {
    bool isValid = true;
    int tollerance = 70;
    final savedPoints = _getPointsFromDb();
    for (var i = 0; i < 3; i++) {
      log((points[i] - savedPoints[i]).distance.toString());
      if ((points[i] - savedPoints[i]).distance > tollerance) {
        isValid = false;
        break;
      }
    }
    _tappedPoints.clear();
    return isValid;
  }
}
