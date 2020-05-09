import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class TakePictureView extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureView({
    Key key,
    @required this.camera
  }) : super(key: key); 

  @override
  _TakePictureViewState createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() { // abre a camera
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() { // fecha a camera
    _controller.dispose();
    super.dispose();
  }

  Future<String> takePhoto() async {
    try {
      await _initializeControllerFuture;

      final uuid = Uuid();
      final fileName = "${uuid.v4()}.jpg"; // "uuid.v4()" hash gerada para o nome o arquivo
      final path = join(
        (await getTemporaryDirectory()).path,
        fileName
      );

      await _controller.takePicture(path); // tira a foto e salva no caminho
      return path;
    }
    catch(ex) {
      print(ex);
      return "";
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova imagem"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera
        ),
        onPressed: () {
          takePhoto().then((path) { // retorna uma string da foto
            Navigator.pop(context, path); // passa o caminho da imagem para a página anterior
          });
        },
      ),
    );
  }
}