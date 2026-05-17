abstract class FavState {}

class FavInitial extends FavState {}
class FavLoading extends FavState {}
class FavUpdated extends FavState {}

class FavSuccess extends FavState {
  final String message;
  FavSuccess(this.message);
}

class FavError extends FavState {
  final String message;
  FavError(this.message);
}