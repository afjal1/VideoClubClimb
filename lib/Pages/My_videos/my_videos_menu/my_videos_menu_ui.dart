import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';

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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bgdibujos.jpg'),
              fit: BoxFit.cover
          )
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon (Icons.arrow_back_ios_rounded,
              size: 31,),
            onPressed: () {
              context.read<VideosCubit>().showInicio();
            },
          ),

          title: const Text (
            "My Zone Climb",
            style: TextStyle (
                fontSize: 25 ,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 5,
          toolbarHeight: 70, //Tamaño de la toolbar
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(50),
              )
          ),
        ),


        body: BlocBuilder<MyVideosMenuBloc, MyVideosMenuState>(
          builder: (BuildContext context, state) {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 60),
              itemCount: state.totalCategories,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                            context
                                .read<MyVideosMenuBloc>()
                                .add(CategoryClickedMyVideosMenuEvent(categoryIndex: -1));
                            return;
                          }
                          context
                              .read<MyVideosMenuBloc>()
                              .add(CategoryClickedMyVideosMenuEvent(categoryIndex: index));
                          String category =
                          context.read<MyVideosMenuBloc>().state.categories[index];
                          String name =
                          context.read<MyVideosMenuBloc>().state.namesubirfoto;
                          context.read<VideosCubit>().showMyVideos(category, index, name);
                        },

                        child: Card(
                          elevation: 10,
                          color: Colors.orange.shade50,
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                          ),

                          child: Row(
                            children: [
                              Container( height: 50,
                                margin: const EdgeInsets.only(right: 20, left: 10, bottom: 10, top: 10),
                                child: const Image(
                                  image: AssetImage('assets/glogo.png'),
                                ),
                              ),

                              Text(
                                state.categories[index],
                                style: const TextStyle(fontSize: 24),
                              ),

                              const Expanded(child: SizedBox()),

                              const Icon (Icons.play_arrow_outlined,

                                size: 40,
                                color: Colors.orange,),

                              SizedBox(width: 10,)

                            ],
                          ),
                        )
                      ),
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
