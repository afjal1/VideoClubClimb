import 'package:equatable/equatable.dart';

import '../zone_videos/zone_videos_bloc.dart';

abstract class ZoneHereState extends Equatable {
  const ZoneHereState();

  @override
  List<Object> get props => [];
}

class InitialState extends ZoneHereState {}

class DeleteLoadingState extends ZoneHereState {}

class FileLoadingState extends ZoneHereState {
  const FileLoadingState(this.response, {this.isFirstFetch = false});
  final TotalFile? response;
  final bool? isFirstFetch;
}

class SuccessState extends ZoneHereState {
  const SuccessState({this.response});
  final TotalFile? response;
}

class ErrorState extends ZoneHereState {
  const ErrorState({this.error});
  final String? error;
}
