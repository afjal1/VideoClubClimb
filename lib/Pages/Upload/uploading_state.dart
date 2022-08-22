import 'package:equatable/equatable.dart';

class UploadingState extends Equatable {
  const UploadingState();

  @override
  List<Object> get props => [];
}

class InitialUploadState extends UploadingState {
  const InitialUploadState();
}

class Uploading extends UploadingState {}

class UploadSuccessful extends UploadingState {}

class UploadFailed extends UploadingState {
  final Exception exception;

  const UploadFailed(this.exception);
}
