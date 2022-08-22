import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';
import 'package:videoclubclimb/functions/native_functions.dart';

class VideoThumbnail extends StatefulWidget {
  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  File? _thumbnailFile;

  @override
  Widget build(BuildContext context) {
    _getVideoThumbnail() async {
      File? file;

      // if (Platform.isMacOS) {
      //   final typeGroup = XTypeGroup(label: 'videos', extensions: ['mov', 'mp4']);
      //   file = await openFile(acceptedTypeGroups: [typeGroup]);
      // } else {
      //   final picker = ImagePicker();
      //   PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);
      //   file = File(pickedFile!.path);
      // }

      // FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      //   type: FileType.video,
      // );
      // file=File(pickedFile!.files.first.path!);

      file = await mFilePicker(type: EFileType.video);

      if (file != null) {
        _thumbnailFile = await VideoCompress.getFileThumbnail(file.path);
        setState(() {});
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('File Thumbnail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _getVideoThumbnail,
                child: const Text('Get File Thumbnail')),
            _buildThumbnail(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (_thumbnailFile != null) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Image(image: FileImage(_thumbnailFile!)),
      );
    }
    return Container();
  }
}
