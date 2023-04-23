import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picauth/gen/assets.gen.dart';
import 'package:picauth/screens/auth_reg/register_screen_vm.dart';
import 'package:picauth/widgets/image_auth.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterScreenVm viewModel;

  Future<ui.Image> getImage() async {
    final ImageProvider imageProvider = Assets.images.defaultImage.provider();
    final Completer<ui.Image> completer = Completer();
    imageProvider.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
              (ImageInfo info, bool _) => completer.complete(info.image)),
        );
    return await completer.future;
  }

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<RegisterScreenVm>(context, listen: false);
    viewModel.tappedPoints.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ImageAuth(
                    image: snapshot.requireData,
                    onRegionsSelected: (points) {
                      viewModel.tappedPoints = points;
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(height: 15.0),
          const Expanded(
              child: Text(
            "Select 3 regions in the picture",
            style: TextStyle(fontSize: 25.0),
          )),
          Consumer<RegisterScreenVm>(builder: (context, model, child) {
            return FilledButton(
              onPressed: model.tappedPoints.isNotEmpty
                  ? () {
                      viewModel.addPointsToDb(model.tappedPoints);
                    }
                  : null,
              style: FilledButton.styleFrom(
                  backgroundColor: model.isAuthenticated ? Colors.green : null),
              child: Text(model.isAuthenticated ? "Registered" : "Register"),
            );
          }),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
