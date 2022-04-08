
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Pages/watch_video/watch_video_event.dart';
import 'package:videoclubclimb/Pages/watch_video/watch_video_state.dart';
import 'package:videoclubclimb/models/File.dart';


import '../../../data_repo.dart';


class WatchVideosBloc extends Bloc<WatchVideosEvent, WatchVideosState> {
  DataRepo dataRepo;
  String category='';
  String name;
  String UIName;
  String url;

  WatchVideosBloc(
      {required this.dataRepo, required this.category, required this.name, required this.UIName, required this.url})
      : super(WatchVideosState(name: name, UIName: UIName)){

    on<GetVideoEvent>(_getVideo);
  }

  _getVideo(GetVideoEvent event, Emitter<WatchVideosState> emit) async {

    // await Future.delayed(const Duration(seconds: 3));
    // // emit(state.copyWith(url: 'https://flutteraws1-storage-d1gd9jgyjrtmpt171431-staging.s3.us-east-1.amazonaws.com/public/Videos/Bikes/bike%202%4061d82671-697e-442d-8851-7333a7f280ea%402021-11-30%2020%3A18%3A40.468672?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjECsaDmFwLXNvdXRoZWFzdC0xIkcwRQIhAOc3lgH%2BnMPEJiLqQ10vuo3X7HCy0ZrSwhQuK2iOqc7uAiAE87dJzXBlNXNNQbQTXlFgb%2B3HypX2%2FY9MvE%2BiyYGdfCqWAwj0%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDc3NTExMTEyNzI2OCIMVdO%2BR9XJ7dES6psmKuoCLoaW3kjwx%2FfPAEps%2FGbK6u5GSgingIVlAOuoPZE2IJ9iiqgWtZp9bjwVAFVZD9zPeYO2pRQUb4Or6Wg%2FSAynDZHFGpQNKMFwWxrtPun%2FRLawVWxOe0nUdCWy%2BS9UzLfv2MiSxQLj6dP3ctZUP4bna4iTjIrU820z5FLDZj9BCYJLrGHBj8oxp6w4ZhWbqHJ%2FZMqE07mkYPsNr%2FGHAu%2FneXW3xp5ojcD8mm%2B4cFY1zzaHZk%2B0k9Hzv%2BMZR9ciuUhYOtq%2FUsFi%2FcALzRv%2FQ6uu4bhf9ESaUTe29ouPom52MSN%2FyiKgN98RGNBN6m%2FQ6Z%2BRWFWMgtm6IWCAmFWW7WRFgZ4lZKxkCt8F7db0T4oERTc0bF0n%2FSATbbpC1A8pi%2BkgWib%2BSaLum40nCGlJ1d7gmsZC8ld4CZKTpVW2BjQuCNsX8ZaAckAV15C5GJ0yhhCz1P8P%2Bh72ZQk%2F3Kp12Hki%2BtiSgqT5YOIFK6ww7d6ZjQY6swKXJyZPlemOnCfeowYP03FITmZ8C81eCJIgnyjTRIKa%2FgSd7uoJOf76sqd0MSxaZSKiYFX2dpfNcghm2PzzkxpQpzbh1zYU%2BsHNrgnis9aMvqAQ%2BDA8r1qt2K94zyQgK85yfEGggcIJSZyrdcR7xcrz2goBkxpDyI5xddc%2BFf4pDu7MTyYGBRsgxr9QJnUXKSpJ7wjUJ9bBuck4shAKT2K9VMkPUF%2FsKoTDF6Ygs3o8h7vAtoPYvTzHPAstFknuWrhVmcvjdUoOvphoey1VviQ%2Fa1MSN%2F%2BZi0UEN0Z%2FGRd38T0WArRjWUeKyi1SCF%2BHjKImm8iWEz4y3TkOtiYt1gfRc80A3NGlBxwa2XPlQ6JhQEvuWrG%2FD5eIXmeeJX%2FoieJEDSVeaYAWMNJXCOZxdW0h994h&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211130T184651Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIA3I6BZGDSOLCB7U6P%2F20211130%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=87a1c81d8914a5768794901088a8db1848f7bd3e047d1e1e7f571994604ec4e8'));
    // //

    //String url = await dataRepo.getVideoURL(category, name);
    //await dataRepo.downloadVideo(category, name);
    //
    List<File> tmp=await dataRepo.listFilesByName(name);
    print("CLICKED");
    String url=await dataRepo.getVideoLink(tmp.first);
    print("CLICKED");
    print('url: ' + url);

    emit(state.copyWith(url: url, loaded: true));


  }
}
