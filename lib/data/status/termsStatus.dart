abstract class TermsState {}

class TermsInitial extends TermsState {}

class TermsLoading extends TermsState {}

class TermsLoaded extends TermsState {
  final String data;

  TermsLoaded(this.data);
}

class TermsOfflineLoaded extends TermsState {
  final String data;

  TermsOfflineLoaded(this.data);
}

class TermsError extends TermsState {
  final String message;

  TermsError(this.message);
}

class TermsNoInternet extends TermsState {}