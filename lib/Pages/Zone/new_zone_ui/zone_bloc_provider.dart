import '../../../data_repo.dart';
import '../../../models/File.dart';
import '../zone_videos/zone_videos_bloc.dart';

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
