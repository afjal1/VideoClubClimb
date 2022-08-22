import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_compress/video_compress.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_bloc.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_event.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_state.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';
import 'package:videoclubclimb/common/kFunctions.dart';

import '../../../functions/native_functions.dart';
import '../../../progress_widget.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  late TextEditingController _nameController;
  // late TextEditingController _gradoController;
  String dropdownValue = '4';
  int gradoIndex = 0;
  late TextEditingController _descController;
  bool uploadValidVideo = false;
  bool uploadValidImage = false;

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

    setState(() {});
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
    // ignore: use_build_context_synchronously
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
  void initState() {
    super.initState();
    context.read<UploadVideoBloc>().category =
        context.read<VideosCubit>().category;
    _nameController = TextEditingController();
    // _gradoController = TextEditingController();

    _descController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    // bool indicator=true;

    Size size = MediaQuery.of(context).size;

    return BlocListener<UploadVideoBloc, UploadVideoState>(
      listener: (BuildContext context, state) {
        if (state.uploaded == true) {
          const snackBar = SnackBar(
            content: Text('ÉXIT: Video upload'),
            backgroundColor: Colors.orange,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bgdibujos.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: MediaQuery.of(context).size.height * 0.0417,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Upload Video",
              style: TextStyle(
                  fontSize: size.width * 0.06555,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: MediaQuery.of(context).size.height * 0.0067,
            toolbarHeight: MediaQuery.of(context).size.height *
                0.0941, //Tamaño de la toolbar
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(50),
            )),
          ),
          body: ListView(
            controller: controller,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0336,
                    left: MediaQuery.of(context).size.width * 0.0694,
                    right: MediaQuery.of(context).size.width * 0.0694),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              'Zone :',
                              style: TextStyle(
                                fontSize: size.width * 0.07125,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth =
                                      MediaQuery.of(context).size.width * 0.0027
                                  ..color = Colors.white,
                              ),
                            ),
                            // Solid text as fill.
                            Text(
                              'Zone :',
                              style: TextStyle(
                                fontSize: size.width * 0.07125,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0056,
                        ),
                        Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              context.read<UploadVideoBloc>().category,
                              style: TextStyle(
                                fontSize: size.width * 0.07125,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth =
                                      MediaQuery.of(context).size.width * 0.0056
                                  ..color = Colors.white,
                              ),
                            ),
                            // Solid text as fill.
                            Text(
                              context.read<UploadVideoBloc>().category,
                              style: TextStyle(
                                fontSize: size.width * 0.07125,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ///FotoView
                    context.watch<UploadVideoBloc>().state.image == ''
                        ? Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    0.0403),
                            height: MediaQuery.of(context).size.height * 0.1345,
                            width: MediaQuery.of(context).size.width * 0.2778,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        : Image.file(
                            File(context.watch<UploadVideoBloc>().state.image),
                            height: MediaQuery.of(context).size.height * 0.1345,
                            width: MediaQuery.of(context).size.width * 0.2778,
                          ),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.0403,
                    ),

                    TextField(
                      controller: _nameController,
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name video',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0556,
                    ),

                    TextField(
                      controller: _descController,
                      minLines: null,
                      maxLines: null,
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0556,
                    ),

                    context.watch<UploadVideoBloc>().state.formSubmissionState
                            is FormSubmitting
                        ? Center(
                            child: Column(
                              children: const [
                                LinearProgressIndicator(
                                  color: Colors.teal,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Uploading...',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : context
                                .watch<UploadVideoBloc>()
                                .state
                                .formSubmissionState is FormSubmissionSuccessful
                            ? Center(
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.check,
                                      color: Colors.teal,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Uploaded',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.orangeAccent,
                                        ),
                                        onPressed: () {
                                          context.read<UploadVideoBloc>().add(
                                                FilePickerUploadVideoButtonClickedEvent(),
                                              );
                                        },
                                        child: const Text('Select Video'),
                                      ),

                                      ///select video

                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.0278,
                                      ),

                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.orangeAccent,
                                        ),
                                        onPressed: () {
                                          context.read<UploadVideoBloc>().add(
                                                ImageFilePickerUploadVideoButtonClickedEvent(),
                                              );
                                        },
                                        child: const Text('Select Image'),
                                      ),

                                      ///Select Image
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.0556,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1667,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0511,
                                        child: DropdownButton<String>(
                                          elevation: 16,
                                          value: dropdownValue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;

                                              if (newValue == '4') {
                                                gradoIndex = 0;
                                              } else if (newValue == '5') {
                                                gradoIndex = 1;
                                              } else if (newValue == '5+') {
                                                gradoIndex = 2;
                                              } else if (newValue == '6a') {
                                                gradoIndex = 3;
                                              } else if (newValue == '6a+') {
                                                gradoIndex = 4;
                                              } else if (newValue == '6b') {
                                                gradoIndex = 5;
                                              } else if (newValue == '6b+') {
                                                gradoIndex = 6;
                                              } else if (newValue == '6c') {
                                                gradoIndex = 7;
                                              } else if (newValue == '6c+') {
                                                gradoIndex = 8;
                                              } else if (newValue == '7a') {
                                                gradoIndex = 9;
                                              } else if (newValue == '7a+') {
                                                gradoIndex = 10;
                                              } else if (newValue == '7b') {
                                                gradoIndex = 11;
                                              } else if (newValue == '7b+') {
                                                gradoIndex = 12;
                                              }
                                            });
                                          },
                                          items: <String>[
                                            '4',
                                            '5',
                                            '5+',
                                            '6a',
                                            '6a+',
                                            '6b',
                                            '6b+',
                                            '6c',
                                            '6c+',
                                            '7a',
                                            '7a+',
                                            '7b',
                                            '7b+'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      BlocBuilder<UploadVideoBloc,
                                          UploadVideoState>(
                                        builder: (context, state) {
                                          return ElevatedButton(
                                            onPressed: state.image.isEmpty ||
                                                    state.video.isEmpty ||
                                                    _nameController.text
                                                        .trim()
                                                        .isEmpty ||
                                                    _descController.text
                                                        .trim()
                                                        .isEmpty
                                                ? null
                                                : () {
                                                    showSnackBar(
                                                      context,
                                                      text:
                                                          'Uploading video, please wait...',
                                                    );

                                                    context
                                                        .read<UploadVideoBloc>()
                                                        .add(
                                                          UploadVideoButtonClickedEvent(
                                                              fileName:
                                                                  _nameController
                                                                      .text,
                                                              grado: gradoIndex,
                                                              desc:
                                                                  _descController
                                                                      .text,
                                                              category: ''),
                                                        );

                                                    // if (context
                                                    //         .watch<UploadVideoBloc>()
                                                    //         .state
                                                    //         .formSubmissionState
                                                    //     is FormSubmissionSuccessful) {
                                                    //   showSnackBar(
                                                    //     context,
                                                    //     text: 'Uploaded Video',
                                                    //   );
                                                    // }
                                                  },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                state.image.isEmpty ||
                                                        state.video.isEmpty ||
                                                        _nameController.text
                                                            .trim()
                                                            .isEmpty ||
                                                        _descController.text
                                                            .trim()
                                                            .isEmpty
                                                    ? Colors.grey
                                                    : Colors.orange,
                                              ),
                                            ),
                                            child: const Text('Upload Video'),
                                          );
                                        },
                                      ),

                                      ///Upload video
                                    ],
                                  ),
                                ],
                              ),

                    ///Botons
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
