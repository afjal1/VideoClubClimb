// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_aws/Media/Videos/videos_cubit.dart';
// import 'my_videos_bloc.dart';
// import 'my_videos_event.dart';
// import 'my_videos_state.dart';
//
// class MyVideosUI extends StatefulWidget {
//   const MyVideosUI({Key? key}) : super(key: key);
//
//   @override
//   _MyVideosUIState createState() => _MyVideosUIState();
// }
//
// class _MyVideosUIState extends State<MyVideosUI> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<MyVideosBloc>().add(GetMyVideosEvent());
//     context.read<MyVideosBloc>().add(GetMyVideosEventGRADO());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/bgdibujos.jpg'), fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.orangeAccent,
//           iconTheme: const IconThemeData(color: Colors.white),
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios_rounded,
//               size: 31,
//             ),
//             onPressed: () {
//               context.read<VideosCubit>().showMyVideosMenu();
//             },
//           ),
//           title: const Text(
//             'My videos',
//             style: TextStyle(
//                 fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           elevation: 5,
//           toolbarHeight: 70,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(0),
//             bottomRight: Radius.circular(50),
//           )),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {},
//             )
//           ],
//         ),
//         body: BlocBuilder<MyVideosBloc, MyVideosState>(
//           builder: (BuildContext context, state) {
//             return ListView.builder(
//               shrinkWrap: true,
//               padding: const EdgeInsets.only(top: 20),
//               itemCount: state.totalVideos, // TODO -- total categories in state
//               itemBuilder: (context, index) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5.0),
//                     child: Column(
//                       children: [
//                         InkWell(
//                           onTap: () {},
//                           splashColor: Colors.orange,
//                           child: Card(
//                             elevation: 10,
//                             color: Colors.orange.shade50,
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 5, horizontal: 20),
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(20), // if you need this
//                               side: const BorderSide(
//                                 color: Colors.orange,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.network(context.watch<MyVideosBloc>().state.images[index],
//                                   width: 75,
//                                   height: 75,),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       context
//                                           .read<MyVideosBloc>()
//                                           .state
//                                           .videos[index],
//                                       style: const TextStyle(fontSize: 24),
//                                     ),
//                                     Text(
//                                       context
//                                           .read<MyVideosBloc>()
//                                           .state
//                                           .grados[index],
//                                       style: const TextStyle(fontSize: 24),
//                                     ),
//                                     Container(
//                                       color: Colors.blue,
//                                       height: 15,
//                                       width: 15,
//                                     ),
//                                   ],
//                                 ),
//                                 const Expanded(
//                                   child: SizedBox(),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.only(right: 15),
//                                   child: ElevatedButton(
//                                     child: const Icon(Icons.delete),
//                                     onPressed: () {
//                                       context.read<MyVideosBloc>().add(
//                                           DeleteVideoButtonClickedEvent(
//                                               index: index));
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';
import 'package:videoclubclimb/generated/assets.dart';
import 'package:videoclubclimb/models/FileType.dart';

import 'my_videos_bloc.dart';
import 'my_videos_event.dart';
import 'my_videos_state.dart';

Color getColorFromGrade(int grade) {
  Color col = Colors.white;

  grade == 0
      ? col = Colors.white
      : grade == 1
          ? col = Colors.red
          : grade == 2
              ? col = Colors.redAccent
              : grade == 3
                  ? col = Colors.blue
                  : grade == 4
                      ? col = Colors.blueAccent
                      : grade == 5
                          ? col = Colors.green
                          : grade == 6
                              ? col = Colors.greenAccent
                              : grade == 7
                                  ? col = Colors.orange
                                  : grade == 8
                                      ? col = Colors.orangeAccent
                                      : grade == 9
                                          ? col = Colors.purple
                                          : grade == 10
                                              ? col = Colors.purpleAccent
                                              : grade == 11
                                                  ? col = Colors.yellow
                                                  : grade == 12
                                                      ? col =
                                                          Colors.yellowAccent
                                                      : col = Colors.black;

  return col;
}

String getTextFromGrade(int grade) {
  String grado = '4';

  grade == 0
      ? grado = '4'
      : grade == 1
          ? grado = '5'
          : grade == 2
              ? grado = '5+'
              : grade == 3
                  ? grado = '6a'
                  : grade == 4
                      ? grado = '6a+'
                      : grade == 5
                          ? grado = '6b'
                          : grade == 6
                              ? grado = '6b+'
                              : grade == 7
                                  ? grado = '6c'
                                  : grade == 8
                                      ? grado = '6c+'
                                      : grade == 9
                                          ? grado = '7a'
                                          : grade == 10
                                              ? grado = '7a+'
                                              : grade == 11
                                                  ? grado = '7b'
                                                  : grade == 12
                                                      ? grado = '7b+'
                                                      : grado = '';

  return grado;
}

class MyVideosUI extends StatefulWidget {
  const MyVideosUI({Key? key}) : super(key: key);

  @override
  _MyVideosUIState createState() => _MyVideosUIState();
}

class _MyVideosUIState extends State<MyVideosUI> {



  @override
  void initState() {
    context.read<MyVideosBloc>().add(LoadMyVideosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              context.read<VideosCubit>().showMyVideosMenu();
            },
          ),



          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.read<MyVideosBloc>().state.categories,
              ),
              IconButton(
                onPressed: () {
                  showCustomDialog(context);
                },
                splashColor: Colors.redAccent,
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          elevation: 5,
          toolbarHeight: 70, //Tamaño de la toolbar
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        body: Stack(children: [
          BlocBuilder<MyVideosBloc, MyVideosState>(
            builder: (BuildContext context, state) {

              if(context.watch<MyVideosBloc>().state.items.isEmpty) {
                return const Center(child: Text("No Content Here"));
              }



              return context.watch<MyVideosBloc>().state.items.first.type==FileType.PHOTOS
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: context
                          .watch<MyVideosBloc>()
                          .state
                          .items
                          .length, // TODO -- total categories in state
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Column(
                              children: [
                                InkWell(
                                  splashColor: Colors.orange,
                                  onTap: () {
                                    context.read<VideosCubit>().watchVideo(
                                          category: context
                                              .read<MyVideosBloc>()
                                              .state
                                              .items
                                              .elementAt(index)
                                              .category,
                                          name: context
                                              .read<MyVideosBloc>()
                                              .state
                                              .items
                                              .elementAt(index)
                                              .name,
                                          UIName: context
                                              .read<MyVideosBloc>()
                                              .state
                                              .items
                                              .elementAt(index)
                                              .name,
                                          url: context
                                              .read<MyVideosBloc>()
                                              .state
                                              .items
                                              .elementAt(index)
                                              .s3key,
                                        );
                                  },
                                  child: Card(

                                    elevation: 10,
                                    color: Colors.orange.shade50,

                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // if you need this
                                      side: const BorderSide(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [

                                        SizedBox(width: 10,),
                                       CircleAvatar(
                                         backgroundColor: Colors.transparent,
                                         child: ClipRRect(

                                            child: Image.network(
                                              context
                                                  .read<MyVideosBloc>()
                                                  .state
                                                  .urls
                                                  .elementAt(index),
                                              // width: 75,
                                              // height: 75,
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, url, error) =>
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          color:
                                                              Colors.transparent)),
                                            ),
                                      borderRadius: BorderRadius.circular(15),


                                          ),
                                         maxRadius: 30,
                                       ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          children: [

                                            SizedBox(height: 10,),
                                            Text(
                                              context
                                                  .read<MyVideosBloc>()
                                                  .state
                                                  .items
                                                  .elementAt(index)
                                                  .name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              getTextFromGrade(context
                                                  .read<MyVideosBloc>()
                                                  .state
                                                  .items
                                                  .elementAt(index)
                                                  .grade),
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              color: getColorFromGrade(context
                                                  .read<MyVideosBloc>()
                                                  .state
                                                  .items[index]
                                                  .grade),
                                              height: 15,
                                              width: 15,
                                            ),
                                            SizedBox(height: 10,)
                                          ],
                                        ),
                                        const Expanded(
                                            flex: 5, child: SizedBox()),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.deepOrange,
                                          ),
                                          child: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onPressed: () {


                                            context.read<MyVideosBloc>().add(
                                                DeleteVideoButtonClickedEvent(
                                                    index: index));


                                          },



                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ]),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 340,
            child: Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      "Do you want to Delete everything in this Sector?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              context
                                  .read<MyVideosBloc>()
                                  .add(DeleteEverythingEvent());
                            },
                            child: Container(
                              child: const Center(
                                  child: Text(
                                "YES",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )),
                              decoration: BoxDecoration(
                                color: const Color(0x60FF0000),
                                border: Border.all(
                                  color: const Color(0x60FF0000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
