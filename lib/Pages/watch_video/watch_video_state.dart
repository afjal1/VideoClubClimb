class WatchVideosState{
  String name;
  String url;
  String UIName;
  bool loaded =false;

  WatchVideosState({
    required this.name,
    this.url = '',
    required this.UIName,
    this.loaded=false,
  });

  WatchVideosState copyWith({
    String? name,
    String? url,
    String? UIName,
    bool? loaded,
  }) {
    return WatchVideosState(
      name: name?? this.name,
      url: url?? this.url,
      UIName: UIName?? this.UIName,
      loaded: loaded?? this.loaded,
    );
  }
}