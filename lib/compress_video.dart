// import 'package:file_picker/file_picker.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:videoclubclimb/functions/native_functions.dart';
import 'package:videoclubclimb/progress_widget.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String _counter = "video";
  int process = 0;
  Uint8List? thumbnailBytes;

  int? videoSize;
  File? file;
  MediaInfo? compressedVideoInfo;

  _uploadVideo() async {
    file = await mFilePicker(type: EFileType.video);
    if (file == null) {
      return;
    }
    _getVideoThumbnail(file);
    compressVideo();

    setState(() {
      setState(() {
        process = 2;
      });
      _counter = file!.path;
    });
  }

  _getVideoThumbnail(File? file) async {
    _getVideoSize(file);

    if (file != null) {
      final thumbnailbytess = await VideoCompress.getByteThumbnail(file.path);
      thumbnailBytes = thumbnailbytess;
      setState(() {});
    }
  }

  _getVideoSize(File? file) async {
    final size = await file!.length();
    videoSize = size;
    setState(() {});
  }

  Future compressVideo() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Dialog(
              child: ProgressDialogWidget(),
            ));
    final info = await compressMyVideo(file);
    setState(() => compressedVideoInfo = info);
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static Future<MediaInfo?> compressMyVideo(File? file) async {
    try {
      await VideoCompress.setLogLevel(0);
      return await VideoCompress.compressVideo(file!.path,
          quality: VideoQuality.MediumQuality,
          includeAudio: true,
          deleteOrigin: false);
    } catch (e) {
      VideoCompress.cancelCompression();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "COM",
          style: TextStyle(
              fontSize: size.width * 0.07125,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: MediaQuery.of(context).size.height * 0.0067,
        toolbarHeight: MediaQuery.of(context).size.height * 0.0941,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(50),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (process == 1) const CircularProgressIndicator.adaptive(),
            if (process == 2)
              (thumbnailBytes == null)
                  ? const CircularProgressIndicator()
                  : Image.memory(
                      thumbnailBytes!,
                      height: 200,
                      width: 200,
                    ),
            _buildSizeWidget(),
            const SizedBox(height: 20),
            Text(
              'File Saved to:+ $_counter',
            ),
            const SizedBox(height: 20),
            compressedVideoInfo == null
                ? const SizedBox()
                : Text(
                    'Compressed Size: ${compressedVideoInfo!.filesize ?? 0} KB'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
              ),
              onPressed: () async {
                setState(() {
                  process = 1;
                });
                _uploadVideo();
              },
              child: const Text('UPLOAD VIDEO'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeWidget() {
    if (videoSize == null) {
      return Container();
    }
    final size = videoSize!;

    return videoSize == null
        ? const SizedBox()
        : Text(
            'File Size: $size KB',
          );
  }
}
