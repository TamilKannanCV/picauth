import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picauth/gen/assets.gen.dart';

import 'package:picauth/screens/home/home_screen_vm.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenVm viewModel;
  @override
  void initState() {
    viewModel = Provider.of<HomeScreenVm>(context, listen: false);
    viewModel.checkIsRegistered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.lotties.lock.lottie(),
            const SizedBox(height: 10.0),
            Text(
              "Image Authentication",
              style: GoogleFonts.cabinCondensed(fontSize: 30.0),
            ),
            Text(
              "This feature let's you authenticate more faster and safer.",
              style: GoogleFonts.cabinCondensed(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            Consumer<HomeScreenVm>(builder: (context, model, child) {
              return FilledButton.icon(
                onPressed: () => viewModel.navigateToRegScrn(context),
                icon: const Icon(Icons.lock_outline),
                label: Text(model.registered ? "Registered" : "Register"),
                style: FilledButton.styleFrom(
                  backgroundColor: model.registered ? Colors.green : null,
                ),
              );
            }),
            const SizedBox(height: 10.0),
            FilledButton.icon(
              onPressed: () => viewModel.navigateToAuthScrn(context),
              icon: const Icon(Icons.lock_open),
              label: const Text("Authenticate"),
            ),
          ],
        ),
      ),
    );
  }
}
