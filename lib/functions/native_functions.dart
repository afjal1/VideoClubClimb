import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> mFilePicker({
  ImageSource source = ImageSource.gallery,
  required EFileType type,
}) async {
  final ImagePicker picker = ImagePicker();

  try {
    if (type == EFileType.video) {
      XFile? xFile = await picker.pickVideo(source: source);
      if (xFile != null) return File(xFile.path);
    } else {
      XFile? xFile = await picker.pickImage(source: source, imageQuality: 25);
      if (xFile != null) return File(xFile.path);
    }
  } on PlatformException catch (e) {
    debugPrint('onPickFile: ${e.message}');
  } catch (e) {
    debugPrint('onPickFile: $e');
  }
  return null;
}

enum EFileType { image, video }
