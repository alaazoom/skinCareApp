import 'package:ecommere2/logic/models/onrProductModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductDetailsState {}

class ProductInitial extends ProductDetailsState {}
class ProductLoading extends ProductDetailsState {}
class ProductSuccess extends ProductDetailsState {
  final ProductDetailsModel product;
  ProductSuccess(this.product);
}
class ProductError extends ProductDetailsState {
  final String message;
  ProductError(this.message);
}