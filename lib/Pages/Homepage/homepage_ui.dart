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
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bgdibujos.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Gravetat Zero",
            style: TextStyle(
                fontSize: size.width * 0.07125,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: MediaQuery.of(context).size.height * 0.0067,
          toolbarHeight: MediaQuery.of(context).size.height * 0.0941,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(50),
          )),
        ),

        body: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (BuildContext context, state) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Card(
                    elevation: MediaQuery.of(context).size.height*	0.0134,
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height*	0.0134,
                        horizontal: MediaQuery.of(context).size.width * 0.0556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.orange,
                        width: MediaQuery.of(context).size.width*	0.0056,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () async {// final updatedItem = File(
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
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height*	0.0134,
                          ),
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
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*	0.0672,
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.0556,
                                  left: MediaQuery.of(context).size.width*	0.0139,
                                ),
                                child: Image(
                                  image: AssetImage('assets/glogo.png'),
                                ),
                              ),
                              Text(
                                'Zone Climb',
                                style: TextStyle(
                                  fontSize: size.width * 0.06555,
                                ),
                              ),

                              Expanded(child: SizedBox()),

                              Icon(
                                Icons.play_arrow_outlined,
                                size: MediaQuery.of(context).size.width*	0.1111,
                                color: Colors.orange,
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width*	0.0278,
                              )
                            ],
                          ) //declare your widget here
                          ),
                    ),
                  ),///Zone Climb

                  SizedBox(
                    height: MediaQuery.of(context).size.height*	0.0336,
                  ),

                  Card(
                    elevation: MediaQuery.of(context).size.height*	0.0134,
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height*	0.0134,
                        horizontal: MediaQuery.of(context).size.width * 0.0556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // if you need this
                      side: BorderSide(
                        color: Colors.orange,
                        width: MediaQuery.of(context).size.width*	0.0056,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<VideosCubit>().showMyVideosMenu();
                      },
                      child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height*	0.0134,
                          ),
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
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*	0.0672,
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.0556,
                                  left: MediaQuery.of(context).size.width*	0.0139,
                                ),
                                child: Image(
                                  image: AssetImage('assets/glogo.png'),
                                ),
                              ),
                              Text(
                                'My videos',
                                style: TextStyle(
                                  fontSize: size.width * 0.06555,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.play_arrow_outlined,
                                size: MediaQuery.of(context).size.width*	0.1111,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*	0.0278,
                              )
                            ],
                          ) //declare your widget here
                          ),
                    ),
                  ),///My videos

                  SizedBox(
                    height: 25,
                  ),

                  Card(
                    elevation: MediaQuery.of(context).size.height*	0.0134,
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height*	0.0134,
                        horizontal: MediaQuery.of(context).size.width * 0.0556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // if you need this
                      side: BorderSide(
                        color: Colors.orange,
                        width: MediaQuery.of(context).size.width*	0.0056,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height*	0.0134,
                          ),
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
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*	0.0672,
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.0556,
                                  left: MediaQuery.of(context).size.width*	0.0139,
                                ),
                                child: Image(
                                  image: AssetImage('assets/glogo.png'),
                                ),
                              ),
                              Text(
                                'Training',
                                style: TextStyle(
                                  fontSize: size.width * 0.06555,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.play_arrow_outlined,
                                size: MediaQuery.of(context).size.width*	0.1111,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*	0.0278,
                              )
                            ],
                          ) //declare your widget here
                          ),
                    ),
                  ),///Training

                  SizedBox(
                    height: 25,
                  ),

                  Card(
                    elevation: MediaQuery.of(context).size.height*	0.0134,
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height*	0.0134,
                        horizontal: MediaQuery.of(context).size.width * 0.0556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // if you need this
                      side: BorderSide(
                        color: Colors.orange,
                        width: MediaQuery.of(context).size.width*	0.0056,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.read<VideosCubit>().showMenuUploadVideos();
                      },
                      child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height*	0.0134,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*	0.0672,
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.0556,
                                  left: MediaQuery.of(context).size.width*	0.0139,
                                ),
                                child: Image(
                                  image: AssetImage('assets/glogo.png'),
                                ),
                              ),
                              Text(
                                'Upload Video',
                                style: TextStyle(
                                  fontSize: size.width * 0.06555,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.play_arrow_outlined,
                                size: MediaQuery.of(context).size.width*	0.1111,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*	0.0278,
                              )
                            ],
                          ) //declare your widget here
                      ),
                    ),
                  ),///Upload Video

                  SizedBox(
                    height: 25,
                  ),

                  Card(
                    elevation: MediaQuery.of(context).size.height*	0.0134,
                    color: Colors.red,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height*	0.0134,
                        horizontal: MediaQuery.of(context).size.width * 0.0556),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // if you need this
                      side: BorderSide(
                        color: Colors.orange,
                        width: MediaQuery.of(context).size.width*	0.0056,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage2()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height*	0.0134,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*	0.0672,
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.0556,
                                  left: MediaQuery.of(context).size.width*	0.0139,
                                ),
                                child: const Image(
                                  image: AssetImage('assets/glogo.png'),
                                ),
                              ),
                              Text(
                                'Compress Video',
                                style: TextStyle(
                                  fontSize: size.width * 0.06555,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Icon(
                                Icons.play_arrow_outlined,
                                size: MediaQuery.of(context).size.width*	0.1111,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*	0.0278,
                              )
                            ],
                          ) //declare your widget here
                          ),
                    ),
                  ),  ///COMPRESS

                  SizedBox(
                    height: MediaQuery.of(context).size.width*	0.1111,
                  ),
                ])
            );
          },
        ),
      ),
    );
  }
}
