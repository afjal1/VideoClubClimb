import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/auth_repo.dart';
import '../../../data_repo.dart';
import '../../Zone/zone_menu/zone_menu_ui.dart';
import '../my_videos/my_videos_bloc.dart';
import '../my_videos/my_videos_ui.dart';
import 'my_videos_menu_bloc.dart';
import 'my_videos_menu_event.dart';
import 'my_videos_menu_state.dart';

class MyVideosMenu extends StatefulWidget {
  const MyVideosMenu({Key? key}) : super(key: key);

  @override
  _MyVideosMenuState createState() => _MyVideosMenuState();
}

class _MyVideosMenuState extends State<MyVideosMenu> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MyVideosMenuBloc>().add(GetCategoriesMyVideosMenuEvent());
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
              size: MediaQuery.of(context).size.height * 0.0417,
            ),
            onPressed: () {
              // context.read<VideosCubit>().showInicio();
              Navigator.pop(context);
            },
          ),

          title: Text(
            "My Zone Climb",
            style: TextStyle(
                fontSize: size.width * 0.07125,
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
        body: BlocBuilder<MyVideosMenuBloc, MyVideosMenuState>(
          builder: (BuildContext context, state) {
            if (state is MyVideoMenuFormSubmitting) {
              return shimmerEffect(size);
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0403),
              itemCount: state.totalCategories,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.0269),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            if (context
                                    .read<MyVideosMenuBloc>()
                                    .state
                                    .currentCategory ==
                                index) {
                              context.read<MyVideosMenuBloc>().add(
                                  CategoryClickedMyVideosMenuEvent(
                                      categoryIndex: -1));
                              return;
                            }
                            context.read<MyVideosMenuBloc>().add(
                                CategoryClickedMyVideosMenuEvent(
                                    categoryIndex: index));
                            String category = context
                                .read<MyVideosMenuBloc>()
                                .state
                                .categories[index];
                            String name = context
                                .read<MyVideosMenuBloc>()
                                .state
                                .namesubirfoto;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (BuildContext context) =>
                                        MyVideosBloc(
                                      dataRepo: context.read<DataRepo>(),
                                      authRepo: context.read<AuthRepo>(),
                                      category: category,
                                    ),
                                    child: const MyVideosUI(),
                                  ),
                                ));

                            // MyVideosUI
                            //      context.read<VideosCubit>().showMyVideos(category, index, name);
                          },
                          child: Card(
                            elevation:
                                MediaQuery.of(context).size.height * 0.0134,
                            color: Colors.orange.shade50,
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.0067,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.0833),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.orange,
                                width: size.width * 0.0056,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.0672,
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.0556,
                                      left: MediaQuery.of(context).size.width *
                                          0.0278,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0134,
                                      top: MediaQuery.of(context).size.height *
                                          0.0134),
                                  child: const Image(
                                    image: AssetImage('assets/glogo.png'),
                                  ),
                                ),
                                Text(
                                  state.categories[index],
                                  style:
                                      TextStyle(fontSize: size.width * 0.0684),
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
}
