import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:video_compress/video_compress.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_event.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_state.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';

import 'package:videoclubclimb/functions/native_functions.dart';

import '../../../data_repo.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  //FilePickerResult? _result;
  DataRepo dataRepo;
  // String category = "";

  File? _videoFile;
  File? _imageFile;

  ///late FilePickerResult? _imageresult;

  UploadVideoBloc({required this.dataRepo}) : super(UploadVideoState()) {
    on<FilePickerUploadVideoButtonClickedEvent>(_filePickerButtonClicked);

    ///video

    on<VideoSelectedUploadEvent>((event, emit) =>
        emit(state.copyWith(video: event.video, image: event.image)));

    on<ImageFilePickerUploadVideoButtonClickedEvent>(
        _ImagefilePickerButtonClicked);

    ///Image

    on<ImageSelectedUploadEvent>(
        (event, emit) => emit(state.copyWith(image: event.image)));

    on<UploadVideoButtonClickedEvent>(_uploadFile);
  }

  //get image => null;

  ///video
  FutureOr<void> _filePickerButtonClicked(
      FilePickerUploadVideoButtonClickedEvent event,
      Emitter<UploadVideoState> emit) async {
    _videoFile = await mFilePicker(type: EFileType.video);

    if (_videoFile != null) {
      emit(state.copyWith(video: _videoFile!.path));
    }
  }

  ///image
  FutureOr<void> _ImagefilePickerButtonClicked(
      ImageFilePickerUploadVideoButtonClickedEvent event,
      Emitter<UploadVideoState> emit) async {
    _imageFile = await mFilePicker(type: EFileType.image);

    if (_imageFile != null) {
      _imageFile = (await ImageCropper().cropImage(
        sourcePath: _imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
          cropFrameColor: Colors.orange,
          activeControlsWidgetColor: Colors.orange,
          toolbarTitle: 'Recortar',
          toolbarColor: Colors.orange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
      ));
      emit(state.copyWith(image: _imageFile!.path));
    }
  }

  FutureOr<void> _uploadFile(UploadVideoButtonClickedEvent event,
      Emitter<UploadVideoState> emit) async {
    //TODO add category to the UI through navigation and access using event

    emit(state.copyWith(formSubmissionState: FormSubmitting()));
    MediaInfo compressedVideo = await compressVideo(_videoFile!);
    print('This is my  ${event.category}');
    await dataRepo.datastoreUploadFile(event.fileName, event.category,
        event.desc, event.grado, compressedVideo.file, _imageFile);

    emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));
  }
}

Future<MediaInfo> compressVideo(File videoFile) async {
  final info = await compressMyVideo(videoFile);
  return info;
}

Future compressMyVideo(File? file) async {
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
