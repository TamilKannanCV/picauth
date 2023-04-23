import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:picauth/screens/auth/auth_screen_vm.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';
import '../../widgets/image_auth.dart';
import 'dart:ui' as ui;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthScreenVm viewModel;

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
    viewModel = Provider.of<AuthScreenVm>(context, listen: false);
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
                    autoHide: true,
                    image: snapshot.requireData,
                    onRegionsSelected: (points) {
                      viewModel.tappedPoints = points;
                      final isValid = viewModel.validate(points);
                      if (isValid == false) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Wrong regions touched"),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text("Congrats!, You are authenticated"),
                          ),
                        );
                      }
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
        ],
      ),
    );
  }
}
