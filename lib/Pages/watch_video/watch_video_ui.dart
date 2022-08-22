import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:videoclubclimb/Pages/watch_video/watch_video_bloc.dart';
import 'package:videoclubclimb/Pages/watch_video/watch_video_event.dart';
import 'package:videoclubclimb/Pages/watch_video/watch_video_state.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchVideo extends StatefulWidget {
  const WatchVideo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WatchVideoState createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  late ChewieController chewieController;

  @override
  void initState() {
    context.read<WatchVideosBloc>().add(GetVideoEvent());
    super.initState();
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chewieController = ChewieController(
        allowPlaybackSpeedChanging: true,
        videoPlayerController: VideoPlayerController.network(
            context.watch<WatchVideosBloc>().state.url),
        fullScreenByDefault: true,
        autoInitialize: true,
        autoPlay: true,
        looping: false,
        showControls: true,
        errorBuilder: (BuildContext context, error) {
          return Center(
            child: Text(error),
          );
        });

    return Scaffold(
        appBar: AppBar(
          title: Text(context.read<WatchVideosBloc>().state.UIName),
          backgroundColor: Colors.orange,
        ),
        body: BlocBuilder<WatchVideosBloc, WatchVideosState>(
            builder: (BuildContext context, state) {
          return context.watch<WatchVideosBloc>().state.loaded
              ? Center(child: Chewie(controller: chewieController))
              : const Center(child: CircularProgressIndicator.adaptive());
        }));
  }
}

// class WatchVideo extends StatefulWidget {
//   const WatchVideo({Key? key}) : super(key: key);
//
//   @override
//   _WatchVideoState createState() => _WatchVideoState();
// }
//
// class _WatchVideoState extends State<WatchVideo> {
//   @override
//   void initState() {
//     super.initState();
//
//     context.read<WatchVideosBloc>().add(GetVideoEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(context.read<WatchVideosBloc>().state.UIName),
//       ),
//       body: BlocBuilder<WatchVideosBloc, WatchVideosState>(
//         builder: (BuildContext context, state) {
//           return Center(
//             child: state.url != ''
//                 ? const RunPlayer()
//                 : const CircularProgressIndicator(
//                     color: Colors.black,
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class RunPlayer extends StatefulWidget {
//   const RunPlayer({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _RunPlayerState createState() => _RunPlayerState();
// }
//
// class _RunPlayerState extends State<RunPlayer> {
//   // final videoPlayerController = VideoPlayerController.network(
//   //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//
//   late ChewieController chewieController;
//
//   late var playerWidget;
//
//   @override
//   void initState() {
//     chewieController = ChewieController(
//         videoPlayerController: VideoPlayerController.network(
//             'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
//         autoPlay: true,
//         looping: true,
//         autoInitialize: true,
//         aspectRatio: 16/9,
//         errorBuilder: (BuildContext context, error){
//           print('error: ' + error);
//           return Center(child: Text(error));
//         }
//     );
//
//     super.initState();
//   }
//
//
//   @override
//   void dispose() {
//     chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Chewie(
//       controller: chewieController,
//     );
//   }
//   // return _controller.value.isInitialized
//   //     ? Column(
//   //     mainAxisAlignment: MainAxisAlignment.center,
//   //     children: [
//   //       Container(
//   //         height: 200,
//   //         child: AspectRatio(
//   //           aspectRatio: _controller.value.aspectRatio,
//   //           child: VideoPlayer(_controller),
//   //         ),
//   //       ),
//   //         const SizedBox(height: 50),
//   //         ElevatedButton(
//   //           onPressed: () {
//   //             setState(() {
//   //               _controller.value.isPlaying
//   //                   ? _controller.pause()
//   //                   : _controller.play()
//   //               ;
//   //
//   //             });
//   //             },
//   //
//   //
//   //         child: Icon(
//   //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//   //         ),
//   //       ),
//   //
//   //       ElevatedButton(onPressed: (){
//   //       _controller.seekTo(Duration(seconds: 10));
//   //
//   //       },
//   //         child: Icon(Icons.ac_unit_rounded))
//   //     ])
//   //         : const CircularProgressIndicator(
//   //       color: Colors.deepPurple,
//   //     );
//   //   }
// }
