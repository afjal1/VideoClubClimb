import 'package:videoclubclimb/Pages/Upload/uploading_state.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';

class UploadVideoState {
  String video;
  String fileName;
  String description;
  bool uploaded;

  /// will tell if the file is "uploaded" or "In progress/ Not uploaded"
  int progress;

  /// will only be relevant if the file is being uploaded
  UploadingState uploadingState;
  String category;

  String image;

  String grado;

  FormSubmissionState formSubmissionState;

  bool get isValidEmail => grado.contains('@') ? true : false;

  UploadVideoState({
    this.formSubmissionState = const InitialFormState(),
    this.video = '',
    this.fileName = '',
    this.description = '',
    this.uploaded = false,
    this.progress = 0,
    this.uploadingState = const InitialUploadState(),
    this.category = '',
    this.image = '',
    this.grado = '',
  });

  UploadVideoState copyWith({
    String? video,
    String? fileName,
    String? description,
    bool? uploaded,
    int? progress,
    UploadingState? uploadingState,
    String? category,
    String? image,
    String? grado,
    FormSubmissionState? formSubmissionState,
  }) {
    return UploadVideoState(
      video: video ?? this.video,
      fileName: fileName ?? this.fileName,
      description: description ?? this.description,
      uploaded: uploaded ?? this.uploaded,
      progress: progress ?? this.progress,
      uploadingState: uploadingState ?? this.uploadingState,
      category: category ?? this.category,
      image: image ?? this.image,
      grado: grado ?? this.grado,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
