import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/foundation.dart';
//import 'package:file_picker/file_picker.dart';

import 'Dart:io';
import 'auth/auth_repo.dart';

import 'models/File.dart' as my_datastore;
import 'models/FileType.dart' as my_datastore_type;

class DataRepo {
  late List<String> Folders;
  late List<String> Files;
  late List<StorageItem> items;

  Future<void> listItems() async {
    try {
      final ListResult result = await Amplify.Storage.list();

      items = result.items;
      // for (int i = 0; i < items.length; i++) {
      //   print('Got items: ${items.elementAt(i).key}');
      // }
    } on StorageException {
      if (kDebugMode) {
        print('$StorageException');
      }
    }
  }
  //
  // Future<List<String>> getCategories() async {
  //   print('**********************************          getCategories (VIDEO)         DATA REPO     ****************************');    await listItems();
  //   List<String> res = [];
  //   for (int i = 0; i < items.length; i++) {
  //     String str = items.elementAt(i).key;
  //     if (str.contains("Videos/")) {
  //       List<String> list = str.split("/");
  //
  //       if (!res.contains(list.elementAt(1)) && str != "Videos/") {
  //         res.add(list.elementAt(1));
  //       }
  //     }
  //   }
  //   return res;
  // }

  //ALL videos
  // List<String> getVideoForUI(String category) {
  //
  //   print('**********************************         getVideoForUI          DATA REPO     ****************************');
  //
  //   List<String> res = [];
  //   int start = 0;
  //   for (int i = 0; i < items.length; i++) {
  //     String str = items.elementAt(i).key;
  //
  //     if (str.contains("Videos/$category")) {
  //       start++;
  //
  //       if (start > 1) {
  //         String tmp = str.split("/").elementAt(2);
  //         res.add(tmp.split("@").first);
  //       }
  //     }
  //   }
  //
  //   return res;
  // }
  //
  // List<String> getVideoNames(String category) {
  //
  //   print('**********************************        getVideoNames           DATA REPO     ****************************');
  //
  //   List<String> res = [];
  //   int start = 0;
  //   for (int i = 0; i < items.length; i++) {
  //     String str = items.elementAt(i).key;
  //
  //     if (str.contains("Videos/$category")) {
  //       start++;
  //
  //       if (start > 1) {
  //         res.add(str.split("/").elementAt(2));
  //       }
  //     }
  //   }
  //
  //   return res;
  // }

  //User Specific Videos

  Future<void> listItemsSectoresMenu() async {
    print(
        '**********************************          listItemsSectores         DATA REPO     ****************************');
    try {
      final ListResult result = await Amplify.Storage.list();
      items = result.items;
      for (int i = 0; i < items.length; i++) {
        print(
            '**********************************************Got items: ${items.elementAt(i).key}');
      }
    } on StorageException catch (e) {
      print('Error listing items: $e');
    }
  }

  Future<List<String>> getCategoriesSectoresMenu() async {
    print(
        '**********************************          getCategories SECTORES (VIDEO)         DATA REPO     ****************************');
    await listItems();
    List<String> res = [];
    for (int i = 0; i < items.length; i++) {
      String str = items.elementAt(i).key;

      if (str.contains("Videos/")) {
        List<String> list = str.split("/");

        if (!res.contains(list.elementAt(1)) && str != "Videos/") {
          res.add(list.elementAt(1));
        }
      }
    }
    return res;
  }

  List<String> getVideoForUISectoresMenu(String category) {
    print(
        '**********************************         getVideoForUI SECTORES          DATA REPO     ****************************');

    List<String> res = [];
    int start = 0;
    for (int i = 0; i < items.length; i++) {
      String str = items.elementAt(i).key;

      if (str.contains("Videos/$category")) {
        start++;

        if (start > 1) {
          String tmp = str.split("/").elementAt(2);
          res.add(tmp.split("@").first);
        }
      }
    }
    return res;
  }

  List<String> getVideoNamesSectoresMenu(String category) {
    print(
        '**********************************        getVideoNames SECTORES          DATA REPO     ****************************');
    List<String> res = [];
    int start = 0;
    for (int i = 0; i < items.length; i++) {
      String str = items.elementAt(i).key;

      if (str.contains("Videos/$category")) {
        start++;

        if (start > 1) {
          res.add(str.split("/").elementAt(2));
        }
      }
    }
    return res;
  }

  Future<void> listItemsSectoresVideos() async {
    print(
        '**********************************          listItemsSectorVideos         DATA REPO     ****************************');
    try {
      final ListResult result = await Amplify.Storage.list();
      items = result.items;
      for (int i = 0; i < items.length; i++) {
        print('Got items: ${items.elementAt(i).key}');
      }
    } on StorageException catch (e) {
      print('Error listing items: $e');
    }
  }

  ///NEW FUNCTIONS STARTED

  Future<bool> datastoreUploadFile(
    String name,
    String category,
    String description,
    int grade,
    File? videoFile,
    File? photoFile,
    // FilePickerResult? video,
    // FilePickerResult? photo,
  ) async {
    AuthRepo authRepo = AuthRepo();
    String userID = await authRepo.getUserIDFromAttributes();
    final item = my_datastore.File(
      name: name,
      type: my_datastore_type.FileType.VIDEO,
      category: category,
      description: description,
      ownerID: userID,
      grade: grade,
      s3key: "Videos/$category/$name@$userID",
      picsS3key: "Fotos/$category/$name@$userID",
    );
    await Amplify.DataStore.save(item);

    //Uploading video
    try {
      // final file = File(video!.files.first.path!);
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: videoFile!,
        key: item.s3key!,
        options: S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest,
        ),
      );
      print('Successfully uploaded Video: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }

    if (photoFile != null) {
      //Upploading Photo
      try {
        // final file = File(photo.files.first.path!);
        final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: photoFile,
          key: item.picsS3key!,
          options: S3UploadFileOptions(
            accessLevel: StorageAccessLevel.guest,
          ),
        );
        print('Successfully uploaded Video: ${result.key}');
      } on StorageException catch (e) {
        print('Error uploading file: $e');
      }
    }

    return true;
  }

  Future<List<my_datastore.File>> listFilesByCategory(
      String category, int? page, int? limit) async {
    List<my_datastore.File> items = [];
    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          pagination: QueryPagination(page: page!, limit: limit!),
          where: my_datastore.File.CATEGORY.eq(category));
    } catch (e) {
      print("Could not query DataStore: $e");
    }
    items;
    print('DataRepo.listFilesByCategory: ${items.length}');
    return items;
  }

  Future<List<my_datastore.File>> listFilesByGrade(int grade) async {
    List<my_datastore.File> items = [];

    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          where: my_datastore.File.GRADE.eq(grade));
    } catch (e) {
      print("Could not query DataStore: $e");
    }

    return items;
  }

  Future<List<my_datastore.File>> listFilesByName(String name) async {
    List<my_datastore.File> items = [];
    print('DataRepo.listFilesByName ${my_datastore.File.classType}');
    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          where: my_datastore.File.NAME.eq(name));
    } catch (e) {
      print("Could not query DataStore: $e");
    }

    return items;
  }

  Future<List<my_datastore.File>> listMyFiles(String ID) async {
    List<my_datastore.File> items = [];

    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          where: my_datastore.File.OWNERID.eq(ID));
    } catch (e) {
      print("Could not query DataStore: $e");
    }

    return items;
  }

  Future<List<my_datastore.File>> listMyFilesByCategory(
      String id, String category) async {
    List<my_datastore.File> items = [];

    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          where: my_datastore.File.OWNERID
              .eq(id)
              .and(my_datastore.File.CATEGORY.eq(category)));
    } catch (e) {
      print("Could not query DataStore: $e");
    }

    return items;
  }

  Future<List<my_datastore.File>> listAll() async {
    List<my_datastore.File> items = [];

    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType);
    } catch (e) {
      print("Could not query DataStore: $e");
    }

    return items;
  }

  Future<List<String>> listCategories() async {
    List<String> categories = [];

    try {
      List<my_datastore.File> items =
          await Amplify.DataStore.query(my_datastore.File.classType);

      for (int i = 0; i < items.length; i++) {
        print('abc $items${items.elementAt(i).name!}');
        if (!categories.contains(items.elementAt(i).category)) {
          categories.add(items.elementAt(i).category!);
        }
      }
      return categories;
    } catch (e) {
      print("Could not query DataStore: $e");
    }

    return categories;
  }

  Future<String> getVideoLink(my_datastore.File item) async {
    String str = "";
    try {
      final GetUrlResult result = await Amplify.Storage.getUrl(
          key: item.s3key!,
          options: S3GetUrlOptions(accessLevel: StorageAccessLevel.guest));

      print('Got Video URL: ${result.url}');

      return result.url;
    } on StorageException catch (e) {
      print('Error getting download URL: $e');
    }

    return str;
  }

  Future<String> getPhotoLink(my_datastore.File item) async {
    String str = "";
    if (item.picsS3key != null) {
      try {
        final GetUrlResult result =
            await Amplify.Storage.getUrl(key: item.picsS3key!);
        print('Got PHOTO URL: ${result.url}');

        return result.url;
      } on StorageException catch (e) {
        print('Error getting download URL: $e');
      }
    }
    return str;
  }

  Future<void> deleteFile(my_datastore.File item) async {
    try {
      final RemoveResult result =
          await Amplify.Storage.remove(key: item.s3key!);
      print('Deleted file: ${result.key}');
    } on StorageException catch (e) {
      print('Error deleting file: $e');
    }

    try {
      final RemoveResult result =
          await Amplify.Storage.remove(key: item.picsS3key!);
      print('Deleted file: ${result.key}');
    } on StorageException catch (e) {
      print('Error deleting file: $e');
    }

    await Amplify.DataStore.delete(item);
  }

  Future<void> deleteCategory(String category, String id) async {
    List<my_datastore.File> items = [];

    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          where: my_datastore.File.CATEGORY
              .eq(category)
              .and(my_datastore.File.OWNERID.eq(id)));

      for (int i = 0; i < items.length; i++) {
        await deleteFile(items.elementAt(i));
        print("Deleted :${items.elementAt(i)}");
      }
    } catch (e) {
      print("Could not query DataStore: $e");
    }
  }

  Future<void> deleteEverything() async {
    List<my_datastore.File> items = await listAll();

    for (int i = 0; i < items.length; i++) {
      deleteFile(items[i]);
    }
  }

  Future<void> deleteAllCategory(String category) async {
    List<my_datastore.File> items = [];

    try {
      items = await Amplify.DataStore.query(my_datastore.File.classType,
          where: my_datastore.File.CATEGORY
              .eq(category)
              .and(my_datastore.File.CATEGORY.eq(category)));

      for (int i = 0; i < items.length; i++) {
        await deleteFile(items.elementAt(i));
        print("Deleted :${items.elementAt(i)}");
      }
    } catch (e) {
      print("Could not query DataStore: $e");
    }
  }
}
