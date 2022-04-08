abstract class MyVideosMenuEvent {}

class GetCategoriesMyVideosMenuEvent extends MyVideosMenuEvent{}


class CategoryClickedMyVideosMenuEvent extends MyVideosMenuEvent {
  int categoryIndex;
  CategoryClickedMyVideosMenuEvent({required this.categoryIndex});
}

