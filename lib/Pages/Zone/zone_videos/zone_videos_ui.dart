import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';

import 'zone_videos_bloc.dart';
import 'zone_videos_event.dart';
import 'zone_videos_state.dart';

class ZoneVideo extends StatefulWidget {
  const ZoneVideo({Key? key}) : super(key: key);

  @override
  _ZoneVideoState createState() => _ZoneVideoState();
}

class _ZoneVideoState extends State<ZoneVideo> {
  TextEditingController searchController = TextEditingController();
  String searchByValue = 'Name';
  String gradoValue = '4';

  @override
  void initState() {
    super.initState();
    context.read<ZoneVideosBloc>().add(GetVideoFiles());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/bgdibujos.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          iconTheme: const IconThemeData(color: Colors.white),

          leading: IconButton(
            icon:  Icon(
              Icons.arrow_back_ios_rounded,
              size: MediaQuery.of(context).size.height*	0.0417,
            ),
            onPressed: () {
              context.read<VideosCubit>().showZoneMenu();
            },
          ),

          actions: <Widget>[
            !context.watch<ZoneVideosBloc>().state.isSearching
                ? IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.read<ZoneVideosBloc>().add(ToggleSearching());
              },
            )
                : Expanded(
              child: Row(
                children: [
                  if (context.watch<ZoneVideosBloc>().state.searchBy == SearchBy.name)
                    Expanded(
                      child: Container(
                        padding:  EdgeInsets.only(
                            left: 100,
                            bottom: MediaQuery.of(context).size.width*	0.2778,
                            right: MediaQuery.of(context).size.width*	0.0556,),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding:  EdgeInsets.only(
                                top: MediaQuery.of(context).size.height*	0.0269,
                                left: MediaQuery.of(context).size.width*	0.0139,),
                            hintText: 'Search',
                            suffixIcon: IconButton(
                              icon: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height*	0.0134,),
                                child: Icon(Icons.search),
                              ),
                              onPressed: () {
                                context.read<ZoneVideosBloc>().add(Search());
                              },
                            ),
                          ),
                          onChanged: (value) {
                            context.read<ZoneVideosBloc>().add(SearchKeywordChanged(value: value));
                          },
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton<String>(
                            elevation: 16,
                            value: gradoValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                gradoValue = newValue!;
                              });
                            },
                            items: <String>['4', '5', '5+', '6a', '6a+', '6b', '6b+', '6c', '6c+', '7a', '7a+', '7b', '7b+']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.height*	0.0134,),
                          IconButton(
                            icon: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height*	0.0134,),
                              child: Icon(Icons.search),
                            ),
                            onPressed: () {
                              context.read<ZoneVideosBloc>().add(Search(grado: gradoValue));
                            },
                          ),
                        ],
                      ),
                    ),
                  DropdownButton<String>(
                    elevation: 16,
                    value: searchByValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        searchByValue = newValue!;
                      });
                      if (newValue == 'Name') {
                        context.read<ZoneVideosBloc>().add(SearchByEvent(searchBy: SearchBy.name));
                      } else if (newValue == 'Grado') {
                        context.read<ZoneVideosBloc>().add(SearchByEvent(searchBy: SearchBy.grado));
                      }
                    },
                    items: <String>['Name', 'Grado'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      context.read<ZoneVideosBloc>().add(ToggleSearching());
                    },
                  ),
                ],
              ),
            ),
          ],

          title: Row(
            children: [
              Text(
                context.read<ZoneVideosBloc>().category,
                style: TextStyle(
                    fontSize: size.width * 0.07125,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),

              IconButton(
                onPressed: () {
                  showCustomDialog(context);
                },
                splashColor: Colors.redAccent,
                icon:  Icon(
                  Icons.delete,
                  size: MediaQuery.of(context).size.height*	0.0403,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: MediaQuery.of(context).size.height*	0.0067,
          toolbarHeight: MediaQuery.of(context).size.height*	0.0941,
          //Tamaño de la toolbar
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(50),
              )),
        ),
        body: BlocBuilder<ZoneVideosBloc, ZoneVideosState>(
          builder: (BuildContext context, state) {

            if(context.watch<ZoneVideosBloc>().state.files.isEmpty) {
              return const Center(child: Text("No Content Here"));
            }

            return context.watch<ZoneVideosBloc>().state.formSubmissionState is FormSubmitting
                || context.watch<ZoneVideosBloc>().state.videoUrls.isEmpty               ? const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.0269),
              itemCount:context.watch<ZoneVideosBloc>().state.isSearching?
              context.watch<ZoneVideosBloc>().state.searchedVideos.length:
              context.watch<ZoneVideosBloc>().state.files.length
              ,
              // TODO -- total categories in state
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height* 0.0067),
                    child: Column(
                      children: [
                        InkWell(splashColor: Colors.orange, onTap: () {
                          if (context.read<ZoneVideosBloc>().state.isSearching)
                          {context.read<VideosCubit>().watchVideo(category: context.read<ZoneVideosBloc>().state.searchedVideos.elementAt(index).category!,
                            name: context.read<ZoneVideosBloc>().state.searchedVideos.elementAt(index).name!,
                            UIName: context.read<ZoneVideosBloc>().state.searchedVideos.elementAt(index).name!,
                            url: context.read<ZoneVideosBloc>().state.searchVideoUrls.elementAt(index),
                          );
                          } else {
                            context.read<VideosCubit>().watchVideo(
                              category: context.read<ZoneVideosBloc>().state.files.elementAt(index).category!,
                              name: context.read<ZoneVideosBloc>().state.files.elementAt(index).name!,
                              UIName: context.read<ZoneVideosBloc>().state.files.elementAt(index).name!,
                              url: context.read<ZoneVideosBloc>().state.videoUrls.elementAt(index),
                            );
                          }
                        },
                          child: Card(
                            elevation: MediaQuery.of(context).size.height* 0.0134,
                            color: Colors.orange.shade50,
                            margin: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height* 0.0067,
                                horizontal: MediaQuery.of(context).size.width* 0.0556),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              // if you need this
                              side: BorderSide(
                                color: Colors.orange,
                                width: MediaQuery.of(context).size.width* 0.0056,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width* 0.0278,
                                      top: MediaQuery.of(context).size.height* 0.0067,
                                      bottom: MediaQuery.of(context).size.height* 0.0067,
                                      right: MediaQuery.of(context).size.width* 0.0278,),
                                  height: MediaQuery.of(context).size.height* 0.1143,
                                  width: MediaQuery.of(context).size.width* 0.2361,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: Image.network(
                                      context.read<ZoneVideosBloc>().state.isSearching
                                          ? context.watch<ZoneVideosBloc>().state.searchImages[index]
                                          : context.watch<ZoneVideosBloc>().state.images[index],
                                      errorBuilder: (context, url, error) => Expanded(flex: 2, child: Container(color: Colors.transparent)),
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded
                                                / loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                ///imagen
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width* 0.0278),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height* 0.0054,
                                      ),

                                      Container(
                                        child: Text(
                                          !context.watch<ZoneVideosBloc>().state.isSearching
                                              ? context.read<ZoneVideosBloc>().state.files[index].name!
                                              : context.read<ZoneVideosBloc>().state.searchedVideos[index].name!,
                                          style:  TextStyle(
                                            fontSize: size.width * 0.04275,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        width: MediaQuery.of(context).size.width* 0.2778,
                                      ),

                                      ///nombre

                                      SizedBox(
                                        height: MediaQuery.of(context).size.height* 0.0094,
                                      ),

                                      Container(
                                        width: MediaQuery.of(context).size.width* 0.2778,
                                        child: Text(
                                          !context.watch<ZoneVideosBloc>().state.isSearching
                                              ? context.read<ZoneVideosBloc>().state.files[index].description!
                                              : context.read<ZoneVideosBloc>().state.searchedVideos[index].description!,
                                          style: const TextStyle(),
                                        ),
                                      ),

                                      ///desceripcion

                                      SizedBox(
                                        height: MediaQuery.of(context).size.height* 0.0054,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: SizedBox()),

                                Container(
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width* 0.0694),
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height* 0.0471,
                                            width: MediaQuery.of(context).size.width* 0.0972,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.orange,
                                                    blurRadius: 5.0,
                                                    spreadRadius: 2.0,
                                                  ),
                                                ],
                                                // boxShadow: [
                                                //   new BoxShadow(
                                                //       color: Colors.black12,
                                                //       blurRadius: 5.0,
                                                //       spreadRadius: 2.0
                                                //   ),
                                                // ],
                                                color: getColorFromGrade(context.read<ZoneVideosBloc>().state.files[index].grade!),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: MediaQuery.of(context).size.width* 0.0028,
                                                    color: Colors.orange)),
                                          ),
                                          Text(!context.watch<ZoneVideosBloc>().state.isSearching
                                              ? getTextFromGrade(context.read<ZoneVideosBloc>().state.files[index].grade!)
                                              : getTextFromGrade(context.read<ZoneVideosBloc>().state.searchedVideos[index].grade!),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],

                                      )
                                    ],
                                  ),
                                ),
                                ///Grado
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
        Size size = MediaQuery.of(context).size;

        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height* 0.43,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width* 0.0556),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.orange,
                  width: MediaQuery.of(context).size.width* 0.03362
              ),
            ),

            child: Scaffold(

              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height* 0.0336,
                        horizontal: MediaQuery.of(context).size.width* 0.0278),
                    child: Text(
                      "Seguro que quieres borrar TODOS los videos de este sector?",
                      style: TextStyle(
                          fontSize: size.width * 0.0798,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height* 0.0134),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            context.read<ZoneVideosBloc>().add(DeleteAllCategoryVideo());
                            Navigator.of(context, rootNavigator: true).pop(true);
                            context.read<VideosCubit>().showZoneMenu();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width* 0.2083,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.pink.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                color: Colors.red,
                                border: Border.all(
                                  color: const Color(0x60FF0000),
                                ),
                                borderRadius: BorderRadius.circular(5)
                            ),

                            child:  Center(
                                child: Text(
                                  "SI",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.0855),
                                )),
                          ),
                        ),

                        SizedBox(width: MediaQuery.of(context).size.width* 0.0861,),

                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop(true);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width* 0.2778,
                            height: MediaQuery.of(context).size.height* 0.1009,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color:  Colors.green,
                              border: Border.all(
                                color: const Color(0x60177103),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: Center(
                                child: Text(
                                  "NO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.0855),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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

// Row(
// children: [
//
// Image.network(context.watch<ZoneVideosBloc>().state.images[index],
// width: 75,
// height: 75,
// errorBuilder: (context, url, error) => Expanded(flex: 2,child: Container(color: Colors.transparent)),
//
//
// ),
// const SizedBox(width: 10,),
// Column(
// children: [
// Text(
// !context
//     .watch<ZoneVideosBloc>()
//     .state
//     .isSearching
// ? context
//     .read<ZoneVideosBloc>()
//     .state
//     .files[index]
//     .name
//     : context
//     .read<ZoneVideosBloc>()
//     .state
//     .searchedVideos[index]
//     .name,
// style: const TextStyle(
// fontSize: 15,
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.start,
// ),
// Text(
// !context
//     .watch<ZoneVideosBloc>()
//     .state
//     .isSearching
// ? getTextFromGrade(context
//     .read<ZoneVideosBloc>()
//     .state
//     .files[index]
//     .grade)
//     : getTextFromGrade(context
//     .read<ZoneVideosBloc>()
//     .state
//     .searchedVideos[index]
//     .grade),
// style: const TextStyle(
//
// fontSize: 15,
// ),
// ),
// Container(
// color: getColorFromGrade(context
//     .read<ZoneVideosBloc>()
//     .state
//     .files[index]
//     .grade),
// height: 15,
// width: 15,
// ),
// ],
// ),
// const Expanded(flex: 5,child: SizedBox()),
// ],
// ),

}

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
      ? col = Colors.yellowAccent
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
