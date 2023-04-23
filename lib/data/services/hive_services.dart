import 'dart:ui';

import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:picauth/data/services/hive_adapters/offset_adapter.dart';

typedef Points = List<Offset>;

@Injectable()
class HiveServices {
  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<CustomOffset>(CustomOffsetAdapter());
    await Hive.openBox<CustomOffset>("auth");
  }

  Future<void> addPoints(Points points) async {
    await Hive.box<CustomOffset>("auth").clear();
    await Hive.box<CustomOffset>("auth").addAll(
      points.map(
        (e) => CustomOffset(e.dx, e.dy),
      ),
    );
  }

  Points getPoints() {
    Points offsets = [];
    for (var x in Hive.box<CustomOffset>("auth").values.toList()) {
      offsets.add(Offset(x.dx, x.dy));
    }
    return offsets;
  }
}
