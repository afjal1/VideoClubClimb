abstract class UploadingState{
  const UploadingState();
}

class InitialUploadState extends UploadingState{
  const InitialUploadState();
}

class Uploading extends UploadingState{}

class UploadSuccessful extends UploadingState{}

class UploadFailed extends UploadingState{
  final Exception exception;

  UploadFailed(this.exception);
}
