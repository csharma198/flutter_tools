import 'dart:io';
import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ARScreen2 extends StatefulWidget {
  @override
  _ARScreen2State createState() => _ARScreen2State();
}

class _ARScreen2State extends State<ARScreen2> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Example'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: onArCoreViewCreated,
      ),
    );
  }

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addProduct();
  }

  void _addProduct() {
    try {
      final file = File('assets/image1.png');
      if (file.existsSync()) {
        final node = ArCoreNode(
          shape: ArCoreCube(
            materials: [
              ArCoreMaterial(
                color: Colors.transparent,
                textureBytes: Uint8List.fromList(
                  file.readAsBytesSync(),
                ),
              ),
            ],
            size: Vector3(0.2, 0.2, 0.2),
          ),
          position: Vector3(0, 0, -1),
        );
        arCoreController.addArCoreNode(node);
      } else {
        print('Image file not found.');
      }
    } catch (e) {
      print('Error loading image: $e');
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
