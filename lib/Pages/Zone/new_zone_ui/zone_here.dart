import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:videoclubclimb/Pages/Zone/new_zone_ui/zone_cubit.dart';
import 'package:videoclubclimb/Pages/Zone/new_zone_ui/zone_state.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_ui.dart';
import 'package:videoclubclimb/Pages/Zone/zone_videos/zone_videos_bloc.dart';
import '../../../data_repo.dart';
import '../../../models/File.dart';
import '../../watch_video/watch_video_bloc.dart';
import '../../watch_video/watch_video_ui.dart';

class NewZoneVideo extends StatefulWidget {
  final String? category;
  const NewZoneVideo({Key? key, this.category}) : super(key: key);

  @override
  NewZoneVideoState createState() => NewZoneVideoState();
}

class NewZoneVideoState extends State<NewZoneVideo> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String searchByValue = 'Name';
  String gradoValue = 'All';

  bool isSearch = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    paginate();
    BlocProvider.of<ZoneHereCubit>(context).loadedVideos(
      widget.category!,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void paginate() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          BlocProvider.of<ZoneHereCubit>(context).loadedVideos(
            widget.category!,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: size.height * 0.0417,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                isSearch = true;
                setState(() {});
              },
            )
          ],

          title: isSearch
              ? TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                )
              : Row(
                  children: [
                    Text(
                      widget.category!,
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
                      icon: Icon(
                        Icons.delete,
                        size: size.height * 0.0403,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
          centerTitle: true,
          elevation: size.height * 0.0067,
          toolbarHeight: size.height * 0.0941,
          //Tamaño de la toolbar
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(50),
          )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: BlocConsumer<ZoneHereCubit, ZoneHereState>(
            listener: (context, state) => {},
            builder: (context, state) {
              if (state is DeleteLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FileLoadingState && state.isFirstFetch!) {
                return videoShimmerEffect(size);
              }
              TotalFile? data;
              bool isLoaded = false;
              if (state is FileLoadingState) {
                data = state.response;
                isLoaded = true;
                if (searchController.text.isNotEmpty) {
                  List<File> files = [];
                  List<String> images = [];
                  List<String> videos = [];
                  for (int i = 0; i < state.response!.files!.length; i++) {
                    if (state.response!.files![i].name!
                        .contains(searchController.text)) {
                      files.add(state.response!.files![i]);
                      images.add(state.response!.images![i]);
                      videos.add(state.response!.videoUrls![i]);
                    }
                    data = TotalFile(
                      files: files,
                      images: images,
                      videoUrls: videos,
                    );
                  }
                }
                if (gradoValue != 'All') {
                  int a = mapGradeToIndex(gradoValue);
                  List<File> files = [];
                  List<String> images = [];
                  List<String> videos = [];
                  for (int i = 0; i < state.response!.files!.length; i++) {
                    if (state.response!.files![i].grade == a) {
                      files.add(state.response!.files![i]);
                      images.add(state.response!.images![i]);
                      videos.add(state.response!.videoUrls![i]);
                    }
                    data = TotalFile(
                      files: files,
                      images: images,
                      videoUrls: videos,
                    );
                  }
                  if (searchController.text.isNotEmpty) {
                    List<File> files = [];
                    List<String> images = [];
                    List<String> videos = [];
                    for (int i = 0; i < state.response!.files!.length; i++) {
                      if (state.response!.files![i].name!
                          .contains(searchController.text)) {
                        files.add(state.response!.files![i]);
                        images.add(state.response!.images![i]);
                        videos.add(state.response!.videoUrls![i]);
                      }
                      data = TotalFile(
                        files: files,
                        images: images,
                        videoUrls: videos,
                      );
                    }
                  }
                }
              } else if (state is SuccessState) {
                if (gradoValue == 'All') {
                  data = state.response;
                  isLoaded = false;
                  if (searchController.text.isNotEmpty) {
                    List<File> files = [];
                    List<String> images = [];
                    List<String> videos = [];
                    for (int i = 0; i < state.response!.files!.length; i++) {
                      if (state.response!.files![i].name!
                          .contains(searchController.text)) {
                        files.add(state.response!.files![i]);
                        images.add(state.response!.images![i]);
                        videos.add(state.response!.videoUrls![i]);
                      }
                      data = TotalFile(
                        files: files,
                        images: images,
                        videoUrls: videos,
                      );
                    }
                  }
                } else {
                  int a = mapGradeToIndex(gradoValue);
                  List<File> files = [];
                  List<String> images = [];
                  List<String> videos = [];
                  for (int i = 0; i < state.response!.files!.length; i++) {
                    if (state.response!.files![i].grade == a) {
                      files.add(state.response!.files![i]);
                      images.add(state.response!.images![i]);
                      videos.add(state.response!.videoUrls![i]);
                    }
                    data = TotalFile(
                      files: files,
                      images: images,
                      videoUrls: videos,
                    );
                  }
                }
              }
              if (data != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //filter by grade
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Filter by grade: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: size.height * 0.0134,
                        ),
                        DropdownButton<String>(
                          elevation: 16,
                          value: gradoValue,
                          onChanged: (String? value) {
                            setState(() {
                              gradoValue = value!;
                            });
                          },
                          items: <String>[
                            'All',
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
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    data.files!.isEmpty
                        ? const Center(
                            child: Text('No hay archivos'),
                          )
                        : Expanded(
                            child: DraggableScrollbar.semicircle(
                              alwaysVisibleScrollThumb: true,
                              labelTextBuilder: (double offset) =>
                                  Text("${offset ~/ 100}"),
                              controller: _scrollController,
                              child: GridView.builder(
                                controller: _scrollController,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount:
                                    data.files!.length + (isLoaded ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == data!.files!.length) {
                                    Timer(const Duration(milliseconds: 30), () {
                                      _scrollController.jumpTo(_scrollController
                                          .position.maxScrollExtent);
                                    });

                                    return _loadingIndicator();
                                  } else {
                                    return InkWell(
                                      splashColor: Colors.orange,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                create:
                                                    (BuildContext context) =>
                                                        WatchVideosBloc(
                                                  dataRepo:
                                                      context.read<DataRepo>(),
                                                  category: data!.files!
                                                      .elementAt(index)
                                                      .category!,
                                                  name: data.files!
                                                      .elementAt(index)
                                                      .name!,
                                                  UIName: data.files!
                                                      .elementAt(index)
                                                      .name!,
                                                  url: data.videoUrls!
                                                      .elementAt(index),
                                                ),
                                                child: const WatchVideo(),
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(),
                                              child: SizedBox(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: FadeInImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      data.images![index],
                                                    ),
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Center(
                                                        child: Image.asset(
                                                          'assets/glogo.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      );
                                                    },
                                                    placeholder:
                                                        const AssetImage(
                                                            'assets/glogo.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.0278),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: size.height *
                                                            0.0054,
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            size.width * 0.2778,
                                                        child: Text(
                                                          data.files![index]
                                                              .name!,
                                                          style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    0.04275,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),

                                                      ///nombre

                                                      SizedBox(
                                                        height: size.height *
                                                            0.0094,
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            size.width * 0.2778,
                                                        child: Text(
                                                          data.files![index]
                                                              .description!,
                                                          style:
                                                              const TextStyle(),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: size.height *
                                                            0.0054,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              height:
                                                                  size.height *
                                                                      0.0471,
                                                              width:
                                                                  size.width *
                                                                      0.0972,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.orange,
                                                                          blurRadius:
                                                                              5.0,
                                                                          spreadRadius:
                                                                              2.0,
                                                                        ),
                                                                      ],
                                                                      color: getColorFromGrade(data
                                                                          .files![
                                                                              index]
                                                                          .grade!),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          width: size.width *
                                                                              0.0028,
                                                                          color:
                                                                              Colors.orange)),
                                                            ),
                                                            Text(
                                                              getTextFromGrade(
                                                                  data
                                                                      .files![
                                                                          index]
                                                                      .grade!),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('No hay archivos'),
                );
              }
            },
          ),
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
            height: size.height * 0.43,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.0556),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.orange, width: size.width * 0.03362),
            ),
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.0336,
                        horizontal: size.width * 0.0278),
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
                    margin: EdgeInsets.only(bottom: size.height * 0.0134),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            BlocProvider.of<ZoneHereCubit>(context)
                                .deleteAllFiles(
                              widget.category!,
                            );
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                            // Navigator.pop(context);
                          },
                          child: Container(
                            width: size.width * 0.2083,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.pink.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                                color: Colors.red,
                                border: Border.all(
                                  color: const Color(0x60FF0000),
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              "SI",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.0855),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.0861,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                          },
                          child: Container(
                            width: size.width * 0.2778,
                            height: size.height * 0.1009,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ],
                              color: Colors.green,
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
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
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

Widget _loadingIndicator() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
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

MasonryGridView videoShimmerEffect(Size size) {
  return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      itemCount: 12,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: shimmer_base,
          highlightColor: shimmer_highlighted,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 4,
                        offset: const Offset(0, 3))
                  ]),
              height: size.height * 0.28,
            ),
          ),
        );
      });
}
