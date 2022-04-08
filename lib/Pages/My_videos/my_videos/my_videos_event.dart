abstract class MyVideosEvent {}

class GetMyVideosEvent extends MyVideosEvent{}

class LoadMyVideosEvent extends MyVideosEvent{}

class DeleteEverythingEvent extends MyVideosEvent{}

class DeleteVideoButtonClickedEvent extends MyVideosEvent{
  int index;

  DeleteVideoButtonClickedEvent({required this.index});
}

class VideoPlayButtonClickedEvent extends MyVideosEvent
{
  int index;
  VideoPlayButtonClickedEvent({required this.index});
}

class CategoryClickedMyVideosEvent extends MyVideosEvent {
  int categoryIndex;

  CategoryClickedMyVideosEvent({required this.categoryIndex});
}

class GetMyVideosEventGRADO extends MyVideosEvent{}

