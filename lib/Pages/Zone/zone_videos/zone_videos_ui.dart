import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_ui.dart';
import 'package:videoclubclimb/models/File.dart';
import '../../../data_repo.dart';
import '../../watch_video/watch_video_bloc.dart';
import '../../watch_video/watch_video_ui.dart';
import 'zone_videos_bloc.dart';
import 'zone_videos_event.dart';
import 'zone_videos_state.dart';

class ZoneVideo extends StatefulWidget {
  const ZoneVideo({Key? key}) : super(key: key);

  @override
  ZoneVideoState createState() => ZoneVideoState();
}

class ZoneVideoState extends State<ZoneVideo> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<FetchedData> fetchedData = [];

  String searchByValue = 'Name';
  String gradoValue = '4';
  int page = 0;
  List<File>? files = [];
  List<String>? videoUrl = [];
  List<String>? images = [];

  List<File>? searchFiles = [];
  List<String>? searchVideoUrl = [];
  List<String>? searchImages = [];

  @override
  void initState() {
    super.initState();

    context.read<ZoneVideosBloc>().add(GetVideoFiles(page: page, limit: 10));
    _scrollController.addListener(pagination);
  }

  void pagination() {
    if ((_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0)) {
      if (_scrollController.position.pixels != 0 &&
          context.read<ZoneVideosBloc>().state.files.isNotEmpty) {
        setState(() {
          page++;

          if (_scrollController.position.pixels + 100 <=
              _scrollController.position.maxScrollExtent) return;

          context
              .read<ZoneVideosBloc>()
              .add(GetVideoFiles(page: page, limit: 10));
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent - 200);
            },
          );
        });
      }
    }
  }

  void waiting() {
    //future delay
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                        if (context.watch<ZoneVideosBloc>().state.searchBy ==
                            SearchBy.name)
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 100,
                                bottom: size.width * 0.2778,
                                right: size.width * 0.0556,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    top: size.height * 0.0269,
                                    left: size.width * 0.0139,
                                  ),
                                  hintText: 'Search',
                                  suffixIcon: IconButton(
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.0134,
                                      ),
                                      child: const Icon(Icons.search),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ZoneVideosBloc>()
                                          .add(Search());
                                    },
                                  ),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<ZoneVideosBloc>()
                                      .add(SearchKeywordChanged(value: value));
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
                                SizedBox(
                                  width: size.height * 0.0134,
                                ),
                                IconButton(
                                  icon: Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.0134,
                                    ),
                                    child: const Icon(Icons.search),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<ZoneVideosBloc>()
                                        .add(Search(grado: gradoValue));
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
                              context
                                  .read<ZoneVideosBloc>()
                                  .add(SearchByEvent(searchBy: SearchBy.name));
                            } else if (newValue == 'Grado') {
                              context
                                  .read<ZoneVideosBloc>()
                                  .add(SearchByEvent(searchBy: SearchBy.grado));
                            }
                          },
                          items: <String>['Name', 'Grado']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            context
                                .read<ZoneVideosBloc>()
                                .add(ToggleSearching());
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
          child: BlocBuilder<ZoneVideosBloc, ZoneVideosState>(
            builder: (BuildContext context, state) {
              int loadingWidget = 0;
              if (state is FormSubmitting1 && files!.isEmpty) {
                return videoShimmerEffect(size);
              }
              if (state.videoUrls.isEmpty && files!.isEmpty) {
                return const Center(child: Text('No hay videos'));
              }

              if (state.files.isNotEmpty) {
                files!.addAll(state.files);
                videoUrl!.addAll(state.videoUrls);
                images!.addAll(state.images);
                loadingWidget = 1;
              }
              if (state.isSearching) {
                searchFiles!.addAll(state.searchedVideos);
                searchVideoUrl!.addAll(state.searchVideoUrls);
                searchImages!.addAll(searchImages!);
              }
              if (files!.length < 10 && state.files.isNotEmpty) {
                loadingWidget = 0;
                //future delay

              }
              {
                return DraggableScrollbar.semicircle(
                  alwaysVisibleScrollThumb: true,
                  controller: _scrollController,
                  child: MasonryGridView.count(
                    controller: _scrollController,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: state.isSearching
                        ? searchFiles!.length
                        : files!.length + loadingWidget,
                    itemBuilder: (context, index) {
                      if (index > files!.length) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.only(bottom: 18.0),
                          child: CircularProgressIndicator(),
                        ));
                      } else {
                        return index == files!.length
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.only(bottom: 18.0),
                                child: CircularProgressIndicator(),
                              ))
                            : InkWell(
                                splashColor: Colors.orange,
                                onTap: () {
                                  if (state.isSearching) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (BuildContext context) =>
                                                WatchVideosBloc(
                                              dataRepo:
                                                  context.read<DataRepo>(),
                                              category: searchFiles!
                                                  .elementAt(index)
                                                  .category!,
                                              name: searchFiles!
                                                  .elementAt(index)
                                                  .name!,
                                              UIName: searchFiles!
                                                  .elementAt(index)
                                                  .name!,
                                              url: searchVideoUrl!
                                                  .elementAt(index),
                                            ),
                                            child: const WatchVideo(),
                                          ),
                                        ));
                                  } else {
                                    // print('hello');
                                    // context.read<VideosCubit>().watchVideo(
                                    //       category: context
                                    //           .read<ZoneVideosBloc>()
                                    //           .state
                                    //           .files
                                    //           .elementAt(index)
                                    //           .category!,
                                    //       name: context
                                    //           .read<ZoneVideosBloc>()
                                    //           .state
                                    //           .files
                                    //           .elementAt(index)
                                    //           .name!,
                                    //       UIName: context
                                    //           .read<ZoneVideosBloc>()
                                    //           .state
                                    //           .files
                                    //           .elementAt(index)
                                    //           .name!,
                                    //       url: context
                                    //           .read<ZoneVideosBloc>()
                                    //           .state
                                    //           .videoUrls
                                    //           .elementAt(index),
                                    //     );

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (BuildContext context) =>
                                                WatchVideosBloc(
                                              dataRepo:
                                                  context.read<DataRepo>(),
                                              category: files!
                                                  .elementAt(index)
                                                  .category!,
                                              name:
                                                  files!.elementAt(index).name!,
                                              UIName:
                                                  files!.elementAt(index).name!,
                                              url: videoUrl!.elementAt(index),
                                            ),
                                            child: const WatchVideo(),
                                          ),
                                        ));
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
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
                                              image: CachedNetworkImageProvider(
                                                state.isSearching
                                                    ? searchImages![index]
                                                    : images![index],
                                              ),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                  child: Image.asset(
                                                    'assets/glogo.png',
                                                    fit: BoxFit.fill,
                                                  ),
                                                );
                                              },
                                              placeholder: const AssetImage(
                                                  'assets/glogo.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.0278),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: size.height * 0.0054,
                                                ),

                                                SizedBox(
                                                  width: size.width * 0.2778,
                                                  child: Text(
                                                    !state.isSearching
                                                        ? files![index].name!
                                                        : searchFiles![index]
                                                            .name!,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.04275,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),

                                                ///nombre

                                                SizedBox(
                                                  height: size.height * 0.0094,
                                                ),

                                                SizedBox(
                                                  width: size.width * 0.2778,
                                                  child: Text(
                                                    !state.isSearching
                                                        ? files![index]
                                                            .description!
                                                        : searchFiles![index]
                                                            .description!,
                                                    style: const TextStyle(),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: size.height * 0.0054,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: size.height *
                                                            0.0471,
                                                        width:
                                                            size.width * 0.0972,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .orange,
                                                                    blurRadius:
                                                                        5.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ),
                                                                ],
                                                                color: getColorFromGrade(
                                                                    files![index]
                                                                        .grade!),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    width: size
                                                                            .width *
                                                                        0.0028,
                                                                    color: Colors
                                                                        .orange)),
                                                      ),
                                                      Text(
                                                        !state.isSearching
                                                            ? getTextFromGrade(
                                                                files![index]
                                                                    .grade!)
                                                            : getTextFromGrade(state
                                                                .searchedVideos[
                                                                    index]
                                                                .grade!),
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // ListView newMethod(BuildContext context, Size size) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     padding: EdgeInsets.only(top: size.height * 0.0269),
  //     itemCount: context.watch<ZoneVideosBloc>().state.isSearching
  //         ? context.watch<ZoneVideosBloc>().searchFiles.length
  //         : context.watch<ZoneVideosBloc>().state.files.length,
  //     // total categories in state
  //     itemBuilder: (context, index) {
  //       return Center(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(vertical: size.height * 0.0067),
  //           child: Column(
  //             children: [
  //               InkWell(
  //                 splashColor: Colors.orange,
  //                 onTap: () {
  //                   if (context.read<ZoneVideosBloc>().state.isSearching) {
  //                     context.read<VideosCubit>().watchVideo(
  //                           category: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .searchedVideos
  //                               .elementAt(index)
  //                               .category!,
  //                           name: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .searchedVideos
  //                               .elementAt(index)
  //                               .name!,
  //                           UIName: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .searchedVideos
  //                               .elementAt(index)
  //                               .name!,
  //                           url: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .searchVideoUrls
  //                               .elementAt(index),
  //                         );
  //                   } else {
  //                     context.read<VideosCubit>().watchVideo(
  //                           category: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .files
  //                               .elementAt(index)
  //                               .category!,
  //                           name: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .files
  //                               .elementAt(index)
  //                               .name!,
  //                           UIName: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .files
  //                               .elementAt(index)
  //                               .name!,
  //                           url: context
  //                               .read<ZoneVideosBloc>()
  //                               .state
  //                               .videoUrls
  //                               .elementAt(index),
  //                         );
  //                   }
  //                 },
  //                 child: Card(
  //                   elevation: size.height * 0.0134,
  //                   color: Colors.orange.shade50,
  //                   margin: EdgeInsets.symmetric(
  //                       vertical: size.height * 0.0067,
  //                       horizontal: size.width * 0.0556),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(20),
  //                     // if you need this
  //                     side: BorderSide(
  //                       color: Colors.orange,
  //                       width: size.width * 0.0056,
  //                     ),
  //                   ),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         margin: EdgeInsets.only(
  //                           left: size.width * 0.0278,
  //                           top: size.height * 0.0067,
  //                           bottom: size.height * 0.0067,
  //                           right: size.width * 0.0278,
  //                         ),
  //                         height: size.height * 0.1143,
  //                         width: size.width * 0.2361,
  //                         child: ClipRRect(
  //                           borderRadius: BorderRadius.circular(45),
  //                           child: Image.network(
  //                             context.read<ZoneVideosBloc>().state.isSearching
  //                                 ? context
  //                                     .watch<ZoneVideosBloc>()
  //                                     .state
  //                                     .searchImages[index]
  //                                 : context
  //                                     .watch<ZoneVideosBloc>()
  //                                     .state
  //                                     .images[index],
  //                             errorBuilder: (context, url, error) => Expanded(
  //                                 flex: 2,
  //                                 child: Container(color: Colors.transparent)),
  //                             loadingBuilder: (BuildContext context,
  //                                 Widget child,
  //                                 ImageChunkEvent? loadingProgress) {
  //                               if (loadingProgress == null) {
  //                                 return child;
  //                               }
  //                               return Center(
  //                                 child: CircularProgressIndicator(
  //                                   value: loadingProgress.expectedTotalBytes !=
  //                                           null
  //                                       ? loadingProgress
  //                                               .cumulativeBytesLoaded /
  //                                           loadingProgress.expectedTotalBytes!
  //                                       : null,
  //                                 ),
  //                               );
  //                             },
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),

  //                       ///imagen
  //                       Container(
  //                         margin: EdgeInsets.symmetric(
  //                             horizontal: size.width * 0.0278),
  //                         child: Column(
  //                           // mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(
  //                               height: size.height * 0.0054,
  //                             ),

  //                             SizedBox(
  //                               width: size.width * 0.2778,
  //                               child: Text(
  //                                 !context
  //                                         .watch<ZoneVideosBloc>()
  //                                         .state
  //                                         .isSearching
  //                                     ? context
  //                                         .read<ZoneVideosBloc>()
  //                                         .state
  //                                         .files[index]
  //                                         .name!
  //                                     : context
  //                                         .read<ZoneVideosBloc>()
  //                                         .state
  //                                         .searchedVideos[index]
  //                                         .name!,
  //                                 style: TextStyle(
  //                                   fontSize: size.width * 0.04275,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                                 textAlign: TextAlign.start,
  //                               ),
  //                             ),

  //                             ///nombre

  //                             SizedBox(
  //                               height: size.height * 0.0094,
  //                             ),

  //                             SizedBox(
  //                               width: size.width * 0.2778,
  //                               child: Text(
  //                                 !context
  //                                         .watch<ZoneVideosBloc>()
  //                                         .state
  //                                         .isSearching
  //                                     ? context
  //                                         .read<ZoneVideosBloc>()
  //                                         .state
  //                                         .files[index]
  //                                         .description!
  //                                     : context
  //                                         .read<ZoneVideosBloc>()
  //                                         .state
  //                                         .searchedVideos[index]
  //                                         .description!,
  //                                 style: const TextStyle(),
  //                               ),
  //                             ),

  //                             ///desceripcion

  //                             SizedBox(
  //                               height: size.height * 0.0054,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       const Expanded(child: SizedBox()),

  //                       Container(
  //                         margin: EdgeInsets.only(right: size.width * 0.0694),
  //                         child: Column(
  //                           children: [
  //                             Stack(
  //                               alignment: Alignment.center,
  //                               children: [
  //                                 Container(
  //                                   height: size.height * 0.0471,
  //                                   width: size.width * 0.0972,
  //                                   decoration: BoxDecoration(
  //                                       shape: BoxShape.rectangle,
  //                                       boxShadow: const [
  //                                         BoxShadow(
  //                                           color: Colors.orange,
  //                                           blurRadius: 5.0,
  //                                           spreadRadius: 2.0,
  //                                         ),
  //                                       ],
  //                                       // boxShadow: [
  //                                       //   new BoxShadow(
  //                                       //       color: Colors.black12,
  //                                       //       blurRadius: 5.0,
  //                                       //       spreadRadius: 2.0
  //                                       //   ),
  //                                       // ],
  //                                       color: getColorFromGrade(context
  //                                           .read<ZoneVideosBloc>()
  //                                           .state
  //                                           .files[index]
  //                                           .grade!),
  //                                       borderRadius: BorderRadius.circular(10),
  //                                       border: Border.all(
  //                                           width: size.width * 0.0028,
  //                                           color: Colors.orange)),
  //                                 ),
  //                                 Text(
  //                                   !context
  //                                           .watch<ZoneVideosBloc>()
  //                                           .state
  //                                           .isSearching
  //                                       ? getTextFromGrade(context
  //                                           .read<ZoneVideosBloc>()
  //                                           .state
  //                                           .files[index]
  //                                           .grade!)
  //                                       : getTextFromGrade(context
  //                                           .read<ZoneVideosBloc>()
  //                                           .state
  //                                           .searchedVideos[index]
  //                                           .grade!),
  //                                   style: const TextStyle(
  //                                     fontSize: 15,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                                 shimmerEffect(size)
  //                               ],
  //                             )
  //                           ],
  //                         ),
  //                       ),

  //                       ///Grado
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
                            context
                                .read<ZoneVideosBloc>()
                                .add(DeleteAllCategoryVideo());
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                            Navigator.pop(context);
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

class FetchedData {
  List<File>? files;
  List<String>? videoUrl;
  List<String>? images;

  FetchedData({this.files, this.videoUrl, this.images});
}
