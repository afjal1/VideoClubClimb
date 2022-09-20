import '../../../data_repo.dart';
import '../../../models/File.dart';

class ZoneHereDataProvider {
  DataRepo dataRepo = DataRepo();
  //Get All Files in a Category
  Future<TotalFile> getVideosFiles(
    String category,
    int page,
  ) async {
    List<String> photoLinkList = [];
    List<String> videoLinkList = [];
    List<File> files = [];

    try {
      files = await dataRepo.listFilesByCategory(category, page, 10);

      for (int i = 0; i < files.length; i++) {
        String photoLink = await dataRepo.getPhotoLink(files[i]);
        String videoLink = await dataRepo.getVideoLink(files[i]);
        photoLinkList.add(photoLink);
        videoLinkList.add(videoLink);
      }
      return TotalFile(
          files: files,
          images: photoLinkList,
          videoUrls: videoLinkList,
          firstFetch: true);
    } catch (e) {}
    throw Exception('Error UNable');
  }

//Delete all files from a Category
  Future<void> deleteAllCategory(String category) async {
    try {
      await dataRepo.deleteAllCategory(category);
    } catch (e) {
      throw Exception('Error UNable');
    }
  }
}

int mapGradeToIndex(String? newValue) {
  int gradoIndex = 0;

  if (newValue == '4') {
    gradoIndex = 0;
  } else if (newValue == '5') {
    gradoIndex = 1;
  } else if (newValue == '5+') {
    gradoIndex = 2;
  } else if (newValue == '6a') {
    gradoIndex = 3;
  } else if (newValue == '6a+') {
    gradoIndex = 4;
  } else if (newValue == '6b') {
    gradoIndex = 5;
  } else if (newValue == '6b+') {
    gradoIndex = 6;
  } else if (newValue == '6c') {
    gradoIndex = 7;
  } else if (newValue == '6c+') {
    gradoIndex = 8;
  } else if (newValue == '7a') {
    gradoIndex = 9;
  } else if (newValue == '7a+') {
    gradoIndex = 10;
  } else if (newValue == '7b') {
    gradoIndex = 11;
  } else if (newValue == '7b+') {
    gradoIndex = 12;
  }

  return gradoIndex;
}

class TotalFile {
  final List<File>? files;
  final List<String>? images;
  final List<String>? videoUrls;
  final bool? firstFetch;

  TotalFile({this.files, this.images, this.videoUrls, this.firstFetch});
}
