import 'package:hive_flutter/adapters.dart';

part 'offset_adapter.g.dart';

@HiveType(typeId: 0)
class CustomOffset extends HiveObject{
  @HiveField(0)
  double dx;

  @HiveField(1)
  double dy;

  CustomOffset(this.dx, this.dy);
}
