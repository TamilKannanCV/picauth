import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:picauth/injection.config.dart';

GetIt locator = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async => locator.init();
