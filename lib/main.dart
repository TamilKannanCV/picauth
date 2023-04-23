import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:flutter/material.dart';
import 'package:picauth/screens/auth/auth_screen_vm.dart';

import 'package:picauth/screens/auth_reg/register_screen_vm.dart';
import 'package:picauth/screens/home/home_screen.dart';
import 'package:picauth/screens/home/home_screen_vm.dart';
import 'package:provider/provider.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterCryptography.enable();
  await configureDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => locator<HomeScreenVm>(),
        ),
        ChangeNotifierProvider(
          create: (context) => locator<RegisterScreenVm>(),
        ),
        ChangeNotifierProvider(
          create: (context) => locator<AuthScreenVm>(),
        ),
      ],
      child: MaterialApp(
        title: 'Image Authentication',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    ),
  );
}
