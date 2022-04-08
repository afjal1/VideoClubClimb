import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';




class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String _counter = "video";
  int process=0;

  _compressVideo() async {
    var file;
    // if (Platform.isMacOS) {
    //   final typeGroup = XTypeGroup(label: 'videos', extensions: ['mov', 'mp4']);
    //   file = await openFile(acceptedTypeGroups: [typeGroup]);
    // } else {
    //   final picker = ImagePicker();
    //   PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);
    //   file = File(pickedFile!.path);
    // }


    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    file=File(pickedFile!.files.first.path!);


    if (file == null) {
      return;
    }
    await VideoCompress.setLogLevel(0);
    final MediaInfo? info = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    print("PATH ${info!.path}");

    if (info != null) {
      setState(() {
        setState(() {
          process=2;
        });
        _counter = info.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COM"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            if(process==1)
            const CircularProgressIndicator.adaptive(),

            if(process==2)
            Text(
              'File Saved to:+ $_counter',
            ),

            ElevatedButton(
              onPressed: () async {

                setState(() {
                  process=1;
                });
                    _compressVideo();

              },
              child: const Text('UPLOAD VIDEO'),
            ),

            ElevatedButton(
              onPressed: () {
            VideoCompress.cancelCompression();
            setState(() {
              process=0;
            });
            },
              child: const Text('CANCEL COMPRESSION'),
            ),


          ],
        ),
      ),
    );
  }
}