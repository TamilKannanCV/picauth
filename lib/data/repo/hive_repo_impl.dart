import 'package:injectable/injectable.dart';
import 'package:picauth/data/repo/hive_repo.dart';
import 'package:picauth/data/services/hive_services.dart';

@named
@Injectable(as: HiveRepo)
class HiveRepoImpl implements HiveRepo {
  final HiveServices _services;
  HiveRepoImpl(this._services);

  @override
  Future<void> addPoints(Points points) async {
    await _services.addPoints(points);
  }

  @override
  Points getPoints() {
    return _services.getPoints();
  }
}
