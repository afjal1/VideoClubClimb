import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_bloc.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_event.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_state.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';

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
    // _gradoController.dispose();

    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    bool indicator=true;

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
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 31,
              ),
              onPressed: () {
                context.read<VideosCubit>().showMenuUploadVideos();
              },
            ),
            title: const Text(
              "Upload Video",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 5,
            toolbarHeight: 70,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(50),
            )),
          ),
          body: ListView(
            controller: _controller,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
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
                                fontSize: 25,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white,
                              ),
                            ),
                            // Solid text as fill.
                            const Text(
                              'Zone :',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              context.read<UploadVideoBloc>().category,
                              style: TextStyle(
                                fontSize: 25,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.white,
                              ),
                            ),
                            // Solid text as fill.
                            Text(
                              context.read<UploadVideoBloc>().category,
                              style: const TextStyle(
                                fontSize: 25,
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
                            margin: const EdgeInsets.only(top: 30),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        : Image.file(
                            File(context.watch<UploadVideoBloc>().state.image),
                            width: 100,
                            height: 100,
                          ),

                    const SizedBox(
                      height: 30,
                    ),

                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name video',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller: _descController,
                      minLines: null,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    context.watch<UploadVideoBloc>().state.formSubmissionState
                            is FormSubmitting
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<UploadVideoBloc>().add(
                                            FilePickerUploadVideoButtonClickedEvent(),
                                          );
                                      setState(() {
                                        uploadValidVideo = true;
                                      });
                                    },
                                    child: const Text('Select Video'),
                                  ),

                                  ///select video

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<UploadVideoBloc>().add(
                                            ImageFilePickerUploadVideoButtonClickedEvent(),
                                          );
                                      setState(() {
                                        uploadValidImage = true;
                                      });
                                    },
                                    child: const Text('Select Image'),
                                  ),

                                  ///Select Image
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 38,
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
                                    // child: TextField(
                                    //
                                    //   controller: _gradoController,
                                    //   decoration: const InputDecoration(
                                    //     border: OutlineInputBorder(),
                                    //     labelText: 'Grado',
                                    //     floatingLabelBehavior: FloatingLabelBehavior.always
                                    //   ),
                                    // ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                      // if (_nameController.text.isNotEmpty &&
                                      //     uploadValidVideo == true &&
                                      //     _gradoController.text.isNotEmpty &&
                                      //     uploadValidImage == true) {
                                      //   context.read<UploadVideoBloc>().add(
                                      //         UploadVideoButtonClickedEvent(
                                      //             fileName: _nameController.text,
                                      //             grado: _gradoController.text,
                                      //             desc: _descController.text,
                                      //             category: ''),
                                      //       );

                                        const snackBar = SnackBar(
                                          content:
                                              Text('Uploading video, please wait...'),
                                          backgroundColor: Colors.orange,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);

                                        // setState(() {
                                        //   uploadValidVideo = false;
                                        //   uploadValidImage = false;
                                        //
                                        //   _nameController.clear();
                                        //   //_gradoController.clear();
                                        //
                                        //   _descController.clear();
                                        //
                                        //   ///BO
                                        // });
                                        //


                                      context.read<UploadVideoBloc>().add(
                                            UploadVideoButtonClickedEvent(
                                                fileName: _nameController.text,
                                                grado: gradoIndex,
                                                desc: _descController.text,
                                                category: ''),
                                          );


                                        const snackBar2 = SnackBar(
                                          content:
                                          Text('Uploaded Video'),
                                          backgroundColor: Colors.orange,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar2);


                                    },
                                    child: const Text('Upload Video'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              uploadValidVideo == true &&
                                                      uploadValidImage == true
                                                  ? Colors.orange
                                                  : Colors.grey),
                                    ),
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
