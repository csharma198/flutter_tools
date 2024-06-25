import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' show Vector2, Vector3, Vector4;
import 'package:flutter/services.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ArCoreController arCoreController;
  ArCoreNode? currentImageNode;
  final List<String> imagePaths = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
    // Add paths for your 10 images
  ];

  @override
  void initState() {
    super.initState();
    currentImageNode = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Table Images'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showImageOnTable(imagePaths[index]);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePaths[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
  }

  void _showImageOnTable(String imagePath) async {
    if (currentImageNode != null) {
      arCoreController.removeNode(nodeName: currentImageNode!.name);
      currentImageNode = null;
    }

    Uint8List textureBytes = await _loadTextureBytes(imagePath);
    ArCoreNode imageNode = ArCoreNode(
      shape: ArCoreCube(
        materials: [
          ArCoreMaterial(
            color: Colors.transparent,
            textureBytes: textureBytes,
          ),
        ],
        size: Vector3(0.5, 0.5, 0.5),
      ),
      position: Vector3(0, 0, -1), // Adjust position as needed
      rotation: Vector4(0, 0, 0, 0), // Adjust rotation as needed
    );

    arCoreController.addArCoreNode(imageNode);
    currentImageNode = imageNode;
    }

  Future<Uint8List> _loadTextureBytes(String assetPath) async {
    ByteData? data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
    }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
