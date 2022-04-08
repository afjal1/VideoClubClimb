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
              context.read<VideosCubit>().showInicio();
            },
          ),
          title: const Text(
            "Zone Climb",
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 40,
              ),


              onPressed: () async {
                context.read<ZoneMenuBloc>().add(DeleteEverything());
              },
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          centerTitle: true,
          elevation: 5,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(50),
          )),
        ),
        body: BlocBuilder<ZoneMenuBloc, ZoneMenuState>(
          builder: (BuildContext context, state) {





            return (context.watch<ZoneMenuBloc>().state.formSubmissionState
                    is FormSubmitting || context.watch<ZoneMenuBloc>().state.deleting==true)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 60),
                    itemCount: state.totalCategories,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20), //entre sector y sector
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
                                  elevation: 10,
                                  color: Colors.orange.shade50,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
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
                                      Container(
                                        height: 50,
                                        margin: const EdgeInsets.only(
                                            right: 20,
                                            left: 10,
                                            bottom: 10,
                                            top: 10),
                                        child: const Image(
                                          image: AssetImage('assets/glogo.png'),
                                        ),
                                      ),
                                      Text(
                                        state.categories[index],
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      const Icon(
                                        Icons.play_arrow_outlined,
                                        size: 40,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(
                                        width: 10,
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
}
