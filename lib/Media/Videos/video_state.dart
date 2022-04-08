abstract class VideoState{}

///*********************** HomePage ***************///
class InitialStateOfVideos extends VideoState{}

class ViewInicio extends VideoState{}

///*********************** ZONE Menu/Videos ***************///
class ViewingZoneMenu extends VideoState{}

class ViewingZoneVideos extends VideoState{
  String category;
  int currentCategory;



  ViewingZoneVideos({required this.category, required this.currentCategory});
}


///*********************** My Videos Menu/Videos ***************///
class ViewingMyVideosMenu extends VideoState{}

class ViewingMyVideos extends VideoState{
  String category;
  int currentCategory;
  String name;

  ViewingMyVideos({required this.category, required this.currentCategory, required this.name,});
}


///************************UPLOAD Zone/Video *********************///
class ViewingMenuUploadVideos extends VideoState{}

class ViewingUploadVideos extends VideoState{}


///************************UPLOAD Zone/Video *********************///
class WatchingVideo extends VideoState{
  String category;
  String name;
  String UIName;
  String url;

  WatchingVideo({required this.category, required this.name, required this.UIName, required this.url});
}