import 'package:flutter/material.dart';
import 'package:movierecommender/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:movierecommender/screens/signin_screen.dart';
import 'dart:io';

class MobileFunctionalityScreen extends StatefulWidget {
  const MobileFunctionalityScreen({Key? key}) : super(key: key);

  @override
  _MobileFunctionalityScreenState createState() => _MobileFunctionalityScreenState();
}

class _MobileFunctionalityScreenState extends State<MobileFunctionalityScreen> {
  late CameraController _cameraController;
  late BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();


    availableCameras().then((cameras) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _takePicture() async {
    try {
      final XFile picture = await _cameraController.takePicture();
      showDialog(
        context: _scaffoldContext,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.file(File(picture.path)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("232430"),
        iconTheme: IconThemeData(color: hexStringToColor("DDDEEB")),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              });
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          _scaffoldContext = context; 
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: hexStringToColor("232430"),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _takePicture,
                    child: Text('Take Picture'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
