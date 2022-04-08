abstract class FormSubmissionState{
  const FormSubmissionState();
}

class InitialFormState extends FormSubmissionState{
  const InitialFormState();
}

class FormSubmitting extends FormSubmissionState{}

class FormSubmissionSuccessful extends FormSubmissionState{}

class FormSubmissionFailed extends FormSubmissionState{
  final Exception exception;

  FormSubmissionFailed(this.exception);
}
