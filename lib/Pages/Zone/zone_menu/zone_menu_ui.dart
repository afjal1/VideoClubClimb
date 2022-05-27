import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_bloc.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_event.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_state.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';

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

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bgdibujos.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
              size: MediaQuery.of(context).size.height*	0.0417,
            ),
            onPressed: () {
              context.read<VideosCubit>().showInicio();
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
                size: MediaQuery.of(context).size.height*	0.0538,
              ),
              onPressed: () async {
                context.read<ZoneMenuBloc>().add(DeleteEverything());
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height*	0.0134,
            ),
          ],
          centerTitle: true,
          elevation: MediaQuery.of(context).size.height*	0.0067,
          toolbarHeight: MediaQuery.of(context).size.height*	0.0941, //Tamaño de la toolbar
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(50),
          )),
        ),
        body: BlocBuilder<ZoneMenuBloc, ZoneMenuState>(
          builder: (BuildContext context, state) {
            return (context.watch<ZoneMenuBloc>().state.formSubmissionState
                        is FormSubmitting ||
                    context.watch<ZoneMenuBloc>().state.deleting == true)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*	0.0403),
                    itemCount: state.totalCategories,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.0269), //entre sector y sector
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
                                  context
                                      .read<VideosCubit>()
                                      .showZoneVideos(category, index);
                                },
                                child: Card(
                                  elevation: MediaQuery.of(context).size.height*	0.0134,
                                  color: Colors.orange.shade50,
                                  margin: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context).size.height*	0.0067,
                                      horizontal: MediaQuery.of(context).size.width*	0.0833
                                  ),
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
                                      Container( height: MediaQuery.of(context).size.height*	0.0672,
                                        margin: EdgeInsets.only(
                                            right: MediaQuery.of(context).size.width*	0.0556,
                                            left: MediaQuery.of(context).size.width*	0.0278,
                                            bottom: MediaQuery.of(context).size.height*	0.0134,
                                            top: MediaQuery.of(context).size.height*	0.0134),
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

                                      Icon (Icons.play_arrow_outlined,
                                        size: size.height * 0.0538,
                                        color: Colors.orange,
                                      ),

                                      SizedBox(width: size.width * 0.0278,)

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
}
