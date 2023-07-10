import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/navigation/app_router.gr.dart';

import '../../keys/asset_path.dart';
import '../../utils/styles/colors.dart';

class TakePhotoWithCamera extends StatefulWidget {
  final void Function(String imagePath, BuildContext context) onPhotoSelected;
  final bool enableAvatarOverlayEnable;

  const TakePhotoWithCamera({
    super.key,
    required this.onPhotoSelected,
    required this.enableAvatarOverlayEnable,
  });

  @override
  State<TakePhotoWithCamera> createState() => _TakePhotoWithCameraState();
}

class _TakePhotoWithCameraState extends State<TakePhotoWithCamera> {
  late Future<List<CameraDescription>> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late Size size;
  bool swtichCamera = false;

  @override
  void initState() {
    super.initState();
    _cameras = availableCameras();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _makePhotoWithCamera(
      {required Function(String imgPaht) onPhotoMade}) async {
    try {
      await _initializeControllerFuture;
      final imageFile = await _controller.takePicture();
      onPhotoMade(imageFile.path);
    } on PlatformException catch (error) {
      print(error);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        FutureBuilder(
          future: _cameras,
          builder: (context, snapshot) {
            final cameras = snapshot.data ?? [];
            _controller = CameraController(
              swtichCamera ? cameras[1] : cameras[0],
              ResolutionPreset.high,
            );
            _initializeControllerFuture = _controller.initialize();
            _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);

            return FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: size.width,
                    height: size.height,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 52.0),
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: FloatingActionButton(
              backgroundColor: CustomPalette.white,
              child: SvgPicture.asset(
                AssetPath.arrowTriangle2,
                color: CustomPalette.black65,
              ),
              onPressed: () {
                setState(() {
                  swtichCamera = !swtichCamera;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              height: 75.0,
              width: 75.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color.fromRGBO(255, 255, 255, 0.6),
                  width: 2,
                ),
              ),
              child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () async {
                  await _makePhotoWithCamera(onPhotoMade: (imgPaht) {
                    context.router.push(ImageCroppingScreenRoute(
                      imagePaht: imgPaht,
                      enableAvatarOverlayEnable:
                          widget.enableAvatarOverlayEnable,
                      onPhotoSelected: widget.onPhotoSelected,
                    ));
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
