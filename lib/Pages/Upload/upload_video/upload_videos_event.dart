abstract class UploadVideoEvent {}

class UploadVideoCategoryEvent extends UploadVideoEvent {}

///select video
class FilePickerUploadVideoButtonClickedEvent extends UploadVideoEvent {}

class VideoSelectedUploadEvent extends UploadVideoEvent {
  /// File object here maybe or whatever file picker returns
  String video;
  String image;

  VideoSelectedUploadEvent({required this.video, required this.image});
}

///select image
class ImageFilePickerUploadVideoButtonClickedEvent extends UploadVideoEvent {}

class ImageSelectedUploadEvent extends UploadVideoEvent {
  /// File object here maybe or whatever file picker returns
  String image;

  ImageSelectedUploadEvent({required this.image});
}

///upload image  video grado and name
class UploadVideoButtonClickedEvent extends UploadVideoEvent {
  String fileName;
  int grado;
  String category;
  String desc;

  ///BORRAR

  UploadVideoButtonClickedEvent(
      {required this.fileName,
      required this.desc,
      required this.category,
      required this.grado});
}
