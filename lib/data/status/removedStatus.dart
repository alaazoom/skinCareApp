abstract class RemoveCartState {}

class RemoveCartInitial extends RemoveCartState {}

class RemoveCartLoading extends RemoveCartState {}

class RemoveCartSuccess extends RemoveCartState {
  final String message;

  RemoveCartSuccess(this.message);
}

class RemoveCartError extends RemoveCartState {
  final String message;

  RemoveCartError(this.message);
}