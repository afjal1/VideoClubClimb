import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_bloc.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_event.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_state.dart';



class UploadVideoMenu extends StatefulWidget {

  const UploadVideoMenu({Key? key}) : super(key: key);


  @override
  _UploadVideoMenuState createState() => _UploadVideoMenuState();
}

class _UploadVideoMenuState extends State<UploadVideoMenu> {


  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<UploadVideoMenuBloc>().add(GetCategoriesUploadVideoMenuEvent());
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
          iconTheme: const IconThemeData(color: Colors.white),

          leading: IconButton(
            icon: const Icon (Icons.arrow_back_ios_rounded,
              size: 31,),
            onPressed: () {
              context.read<VideosCubit>().showInicio();
            },
          ),

          title: const Text (
            "Select Zone",
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


        body: BlocBuilder<UploadVideoMenuBloc, UploadVideoMenuState>(
          builder: (BuildContext context, state) {
            return ListView.builder(

              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 30, bottom: 60), //distancia columna top
              itemCount: state.totalCategories,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20), //entre sector y sector
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: () {
                          if (context
                              .read<UploadVideoMenuBloc>()
                              .state
                              .currentCategory ==
                              index) {
                            context
                                .read<UploadVideoMenuBloc>()
                                .add(CategoryClickedUploadVideoMenuEvent(categoryIndex: -1));

                            return;
                          }

                          context
                              .read<UploadVideoMenuBloc>()
                              .add(CategoryClickedUploadVideoMenuEvent(categoryIndex: index));



                          String category =
                          context.read<UploadVideoMenuBloc>().state.categories[index];

                          context.read<VideosCubit>().showUploadVideos(category: category);

                        },



                        child: Card(
                          elevation: 10,
                          color: Colors.orange.shade50,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // if you need this
                            side: const BorderSide(
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

                              const SizedBox(width: 10,)

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
