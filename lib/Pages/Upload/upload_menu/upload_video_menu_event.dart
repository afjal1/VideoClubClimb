abstract class UploadVideoMenuEvent {}

class GetCategoriesUploadVideoMenuEvent extends UploadVideoMenuEvent{}


class CategoryClickedUploadVideoMenuEvent extends UploadVideoMenuEvent {
  int categoryIndex;



  CategoryClickedUploadVideoMenuEvent({required this.categoryIndex});
}


class RefreshListsSubirVideoMenuEvent extends UploadVideoMenuEvent{}


class SearchEventSubirVideoMenu extends UploadVideoMenuEvent{
  String searchedKeyword;

  SearchEventSubirVideoMenu({required this.searchedKeyword});
}