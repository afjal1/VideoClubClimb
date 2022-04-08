
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';


import '../../compress_video.dart';
import 'homepage_bloc.dart';
import 'homepage_event.dart';
import 'homepage_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    context.read<HomepageBloc>().add(GetHomepageEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
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

          title: const Text (
            "Gravetat Zero",
            style: TextStyle (
                fontSize: 25 ,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 5,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(50),
              )
          ),
        ),

        body: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (BuildContext context, state) {
            return Center(

                child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Card(
                        elevation: 10,
                        color: Colors.transparent,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),

                        child: GestureDetector(
                          onTap: () async {

                            // final updatedItem = File(
                            //     Name: "Lorem ipsum dolor sit amet",
                            //     Type: FileType.VIDEO,
                            //     category: "Lorem ipsum dolor sit amet",
                            //     description: "Lorem ipsum dolor sit amet",
                            //     ownerID: "Lorem ipsum dolor sit amet",
                            //     Grade: 1020);
                            // await Amplify.DataStore.save(updatedItem);

                            context.read<VideosCubit>().showZoneMenu();
                          },

                          child: Container(
                              padding: const EdgeInsets.all(10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.orangeAccent,
                                    Colors.yellow.shade300,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),

                              child:  Row(
                                children: [
                                  Container( height: 50,
                                    margin: EdgeInsets.only(right: 20, left: 5,),
                                    child: Image(
                                      image: AssetImage('assets/glogo.png'),
                                    ),
                                  ),

                                  Text('Zone Climb',
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),),

                                  Expanded(child: SizedBox()),

                                  Icon (Icons.play_arrow_outlined,

                                    size: 40,
                                    color: Colors.orange,),

                                  SizedBox(width: 10,)

                                ],
                              )//declare your widget here
                          ),
                        ),
                      ),
                      ///Zone Climb

                      SizedBox(height: 25,),

                      Card(

                        elevation: 10,
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),

                        child: GestureDetector(

                          onTap: (){
                            Navigator.of(context).pop();
                            context.read<VideosCubit>().showMyVideosMenu();
                          },

                          child: Container(
                              padding: EdgeInsets.all(10,),
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.orangeAccent,
                                    Colors.yellow.shade300,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),

                              child:  Row(
                                children: [
                                  Container( height: 50,
                                    margin: EdgeInsets.only(right: 20, left: 5,),
                                    child: Image(
                                      image: AssetImage('assets/glogo.png'),
                                    ),
                                  ),

                                  Text('My videos',
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),),

                                  Expanded(child: SizedBox()),

                                  Icon (Icons.play_arrow_outlined,

                                    size: 40,
                                    color: Colors.orange,),

                                  SizedBox(width: 10,)

                                ],
                              )//declare your widget here
                          ),
                        ),
                      ),   ///My videos

                      SizedBox(height: 25,),

                      Card(

                        elevation: 10,
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),

                        child: GestureDetector(

                          onTap: (){
                          },

                          child: Container(
                              padding: EdgeInsets.all(10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.orangeAccent,
                                    Colors.yellow.shade300,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),

                              child:  Row(
                                children: [
                                  Container( height: 50,
                                    margin: EdgeInsets.only(right: 20, left: 5,),
                                    child: Image(
                                      image: AssetImage('assets/glogo.png'),
                                    ),
                                  ),

                                  Text('Training',
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),),

                                  Expanded(child: SizedBox()),

                                  Icon (Icons.play_arrow_outlined,

                                    size: 40,
                                    color: Colors.orange,),

                                  SizedBox(width: 10,)

                                ],
                              )//declare your widget here
                          ),
                        ),
                      ),   ///Training

                      SizedBox(height: 25,),

                      Card(

                        elevation: 10,
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),

                        child: GestureDetector(
                          onTap: (){
                            context.read<VideosCubit>().showMenuUploadVideos();
                          },

                          child: Container(
                              padding: EdgeInsets.all(10,),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child:  Row(
                                children: [
                                  Container( height: 50,
                                    margin: EdgeInsets.only(right: 20, left: 5,),
                                    child: Image(
                                      image: AssetImage('assets/glogo.png'),
                                    ),
                                  ),

                                  Text('Upload Video',
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),),

                                  Expanded(child: SizedBox()),

                                  Icon (Icons.play_arrow_outlined,

                                    size: 40,
                                    color: Colors.orange,),

                                  SizedBox(width: 10,)

                                ],
                              )//declare your widget here
                          ),
                        ),
                      ),    ///Upload Video

                      SizedBox(height: 25,),

                      Card(

                        elevation: 10,
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // if you need this
                          side: const BorderSide(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),

                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context)=> MyHomePage2()
                            ));
                          },

                          child: Container(
                              padding: const EdgeInsets.all(10,),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child:  Row(
                                children: [
                                  Container( height: 50,
                                    margin: const EdgeInsets.only(right: 20, left: 5,),
                                    child: const Image(
                                      image: AssetImage('assets/glogo.png'),
                                    ),
                                  ),

                                  const Text('Compress Video',
                                    style: TextStyle(
                                      fontSize: 23,
                                    ),),

                                  const Expanded(child: SizedBox()),

                                  const Icon (Icons.play_arrow_outlined,

                                    size: 40,
                                    color: Colors.orange,),

                                  const SizedBox(width: 10,)

                                ],
                              )//declare your widget here
                          ),
                        ),
                      ),

                      const SizedBox(height: 40,),
                    ]
                )
            );
          },
        ),
      ),
    );
  }
}
