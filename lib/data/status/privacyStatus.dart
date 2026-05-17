abstract class PrivacyState {}

class PrivacyInitial extends PrivacyState {}

class PrivacyLoading extends PrivacyState {}

class PrivacyLoaded extends PrivacyState {
  final String data;

  PrivacyLoaded(this.data);
}

class PrivacyOfflineLoaded extends PrivacyState {
  final String data;

  PrivacyOfflineLoaded(this.data);
}

class PrivacyNoInternet extends PrivacyState {}

class PrivacyError extends PrivacyState {
  final String message;

  PrivacyError(this.message);
}