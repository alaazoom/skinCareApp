// import 'dart:io';
// import 'package:ecommere2/data/status/allproductsStatus.dart';
// import 'package:ecommere2/logic/gettingData/getAllProducts.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductsCubit extends Cubit<ProductsState> {
//   final ProductsRepository repo;

//   ProductsCubit(this.repo) : super(ProductsInitial());

//   Future<void> getProducts() async {
//     emit(ProductsLoading());

//     try {
//       final products = await repo.getProducts();
//       emit(ProductsSuccess(products));
//     } on SocketException {
//       emit(ProductsError("No Internet Connection"));
//     } on HttpException {
//       emit(ProductsError("Server Error"));
//     } on FormatException {
//       emit(ProductsError("Bad Response Format"));
//     } catch (e) {
//       emit(ProductsError("Something went wrong"));
//     }
//   }
// }






import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommere2/data/status/allproductsStatus.dart';
import 'package:ecommere2/logic/gettingData/getAllProducts.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository repo;

  ProductsCubit(this.repo) : super(ProductsInitial());

  Future<void> getProducts() async {
    emit(ProductsLoading());

    try {
      final products = await repo.getProducts();
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}