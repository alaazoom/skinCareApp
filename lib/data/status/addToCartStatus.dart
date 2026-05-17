abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final String message;
  CartSuccess(this.message);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
class CartLoadingItem extends CartState {
  final int productId;
  CartLoadingItem(this.productId);
}

class CartLoadingFinished extends CartState {
  final int productId;
  CartLoadingFinished(this.productId);
}