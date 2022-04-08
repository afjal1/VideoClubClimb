
import 'package:videoclubclimb/models/File.dart';
enum SearchBy { name, grado }
class MyVideosState {


  List<File> items;
  List<String> urls;
  String categories;



  String searchedKeyword;

  bool isSearching;
  SearchBy searchBy;


  //////////////////////////

  MyVideosState({
    required this.items,
    required this.categories,
    required this.urls,
    this.searchedKeyword = '',
    this.searchBy = SearchBy.name,
    this.isSearching=false,
  });

  MyVideosState copyWith({
    List<File>? items,
    String? categories,
    List<String>? urls
  }) {
    return MyVideosState(
        items: items ?? this.items,
        categories: categories?? this.categories,
        urls: urls?? this.urls
    );
  }
}
