import 'package:equatable/equatable.dart';
import 'package:ecommere2/logic/models/cartitemModel.dart';

abstract class AllCartState extends Equatable {
  const AllCartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends AllCartState {}

class CartLoading extends AllCartState {}

class CartLoaded extends AllCartState {
  final List<CartItem> items;
  final CartDetails details;

  const CartLoaded(this.items, this.details);

  @override
  List<Object?> get props => [
        items,
        details,
      ];
}

class CartError extends AllCartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartRemoveSuccess extends AllCartState {
  final int crtId;

  const CartRemoveSuccess(this.crtId);

  @override
  List<Object?> get props => [crtId];
}

class CartLoadingItem extends AllCartState {
  final int productId;

  const CartLoadingItem(this.productId);

  @override
  List<Object?> get props => [productId];
}

class CartLoadingFinished extends AllCartState {
  final int productId;

  const CartLoadingFinished(this.productId);

  @override
  List<Object?> get props => [productId];
}