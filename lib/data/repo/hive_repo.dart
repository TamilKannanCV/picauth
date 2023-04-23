import '../services/hive_services.dart';

abstract class HiveRepo {
  Future<void> addPoints(Points points);
  Points getPoints();
}
