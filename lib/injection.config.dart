// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:picauth/data/repo/hive_repo.dart' as _i4;
import 'package:picauth/data/repo/hive_repo_impl.dart' as _i5;
import 'package:picauth/data/services/hive_services.dart' as _i3;
import 'package:picauth/screens/auth/auth_screen_vm.dart' as _i8;
import 'package:picauth/screens/auth_reg/register_screen_vm.dart' as _i7;
import 'package:picauth/screens/home/home_screen_vm.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await gh.factoryAsync<_i3.HiveServices>(
      () {
        final i = _i3.HiveServices();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i4.HiveRepo>(
      () => _i5.HiveRepoImpl(gh<_i3.HiveServices>()),
      instanceName: 'HiveRepoImpl',
    );
    gh.singleton<_i6.HomeScreenVm>(
        _i6.HomeScreenVm(gh<_i4.HiveRepo>(instanceName: 'HiveRepoImpl')));
    gh.singleton<_i7.RegisterScreenVm>(
        _i7.RegisterScreenVm(gh<_i4.HiveRepo>(instanceName: 'HiveRepoImpl')));
    gh.singleton<_i8.AuthScreenVm>(
        _i8.AuthScreenVm(gh<_i4.HiveRepo>(instanceName: 'HiveRepoImpl')));
    return this;
  }
}
