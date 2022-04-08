abstract class ZoneMenuEvent {}


class GetCategoriesZoneMenuEvent extends ZoneMenuEvent{}


class CategoryClickedZoneMenuEvent extends ZoneMenuEvent {
  int categoryIndex;
  CategoryClickedZoneMenuEvent({required this.categoryIndex});
}


class RefreshListsZoneMenuEvent extends ZoneMenuEvent{}


class SearchEventZoneMenu extends ZoneMenuEvent{
  String searchedKeyword;
  SearchEventZoneMenu({required this.searchedKeyword});
}

class DeleteEverything extends ZoneMenuEvent
{}