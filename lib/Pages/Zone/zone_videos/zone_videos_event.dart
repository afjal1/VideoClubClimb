import 'package:videoclubclimb/Pages/Zone/zone_videos/zone_videos_state.dart';
import 'package:videoclubclimb/models/File.dart';

abstract class ZoneVideosEvent {}

class GetVideoFiles extends ZoneVideosEvent{}

class GetZoneVideosEvent extends ZoneVideosEvent {}

class CategoryClickedZoneVideosEvent extends ZoneVideosEvent {
  int categoryIndex;
  CategoryClickedZoneVideosEvent({required this.categoryIndex});
}

class DeleteAllCategoryVideo extends ZoneVideosEvent{}


class DeleteVideoZoneButtonClickedEvent extends ZoneVideosEvent {
  int index;
  DeleteVideoZoneButtonClickedEvent({required this.index});
}

class SearchEvent extends ZoneVideosEvent {
  String searchedKeyword;
  SearchEvent({required this.searchedKeyword});
}

class GetZoneVideosEventGRADO extends ZoneVideosEvent {}

class ToggleSearching extends ZoneVideosEvent {}

class SearchKeywordChanged extends ZoneVideosEvent {
  String value;

  SearchKeywordChanged({
    required this.value,
  });
}

class SearchByEvent extends ZoneVideosEvent {
  SearchBy searchBy;

  SearchByEvent({
    required this.searchBy,
  });
}

class Search extends ZoneVideosEvent {
  String? grado;

  Search({this.grado});
}

class GetImage extends ZoneVideosEvent{
  File file;

  GetImage({required this.file});
}
