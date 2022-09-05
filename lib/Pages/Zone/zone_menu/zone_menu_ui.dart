import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_bloc.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_event.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_state.dart';

import '../../../data_repo.dart';
import '../zone_videos/zone_videos_bloc.dart';
import '../zone_videos/zone_videos_ui.dart';

Color shimmer_base = Colors.grey.shade200;

Color shimmer_highlighted = Colors.grey.shade500;

class ZoneMenu extends StatefulWidget {
  const ZoneMenu({Key? key}) : super(key: key);

  @override
  _ZoneMenuState createState() => _ZoneMenuState();
}

class _ZoneMenuState extends State<ZoneMenu> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ZoneMenuBloc>().add(GetCategoriesZoneMenuEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.orangeAccent,
        statusBarIconBrightness: Brightness.dark));

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
          title: Text(
            "Zone Climb",
            style: TextStyle(
                fontSize: size.width * 0.07125,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: size.height * 0.0538,
              ),
              onPressed: () {
                showCustomDialog(context);
              },
            ),
            SizedBox(
              width: size.height * 0.0134,
            ),
          ],
          centerTitle: true,
          elevation: size.height * 0.0067,
          toolbarHeight: size.height * 0.0941, //Tamaño de la toolbar
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(50),
          )),
        ),
        body: BlocBuilder<ZoneMenuBloc, ZoneMenuState>(
          builder: (BuildContext context, state) {
            if ((state is ZoneMenuFormSubmitting ||
                context.watch<ZoneMenuBloc>().state.deleting == true)) {
              return shimmerEffect(size);
            }
            return state.totalCategories == 0
                ? const Center(child: Text('No hay categorias'))
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: size.height * 0.0403),
                    itemCount: state.totalCategories,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                size.height * 0.0269), //entre sector y sector
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (context
                                          .read<ZoneMenuBloc>()
                                          .state
                                          .currentCategory ==
                                      index) {
                                    context.read<ZoneMenuBloc>().add(
                                        CategoryClickedZoneMenuEvent(
                                            categoryIndex: -1));
                                    return;
                                  }
                                  context.read<ZoneMenuBloc>().add(
                                      CategoryClickedZoneMenuEvent(
                                          categoryIndex: index));
                                  String category = context
                                      .read<ZoneMenuBloc>()
                                      .state
                                      .categories[index];

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (BuildContext context) =>
                                              ZoneVideosBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            category: category,
                                          ),
                                          child: const ZoneVideo(),
                                        ),
                                      ));
                                },
                                child: Card(
                                  elevation: size.height * 0.0134,
                                  color: Colors.orange.shade50,
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.height * 0.0067,
                                      horizontal: size.width * 0.0833),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    // if you need this
                                    side: BorderSide(
                                      color: Colors.orange,
                                      width: size.width * 0.0056,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: size.height * 0.0672,
                                        margin: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0556,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0278,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0134,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0134),
                                        child: const Image(
                                          image: AssetImage('assets/glogo.png'),
                                        ),
                                      ),
                                      Text(
                                        state.categories[index],
                                        style: TextStyle(
                                            fontSize: size.width * 0.0684),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Icon(
                                        Icons.play_arrow_outlined,
                                        size: size.height * 0.0538,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.0278,
                                      )
                                    ],
                                  ),
                                )),
                          ],
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
            height: size.height * 0.366,
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
                      "Seguro que quieres borrar TODOS LOS VIDEOS de la base?",
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
                          onPressed: () async {
                            context
                                .read<ZoneMenuBloc>()
                                .add(DeleteEverything());
                            Navigator.of(context, rootNavigator: true)
                                .pop(true);
                            //  context.read<VideosCubit>().showZoneMenu();
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

ListView shimmerEffect(Size size) {
  return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 30),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: shimmer_base,
          highlightColor: shimmer_highlighted,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
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
              height: size.height * 0.0782,
            ),
          ),
        );
      });
}
