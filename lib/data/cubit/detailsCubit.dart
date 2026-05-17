import 'package:ecommere2/data/status/detailsStatus.dart';
import 'package:ecommere2/logic/gettingData/getDetails.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepository repo;

  ProductDetailsCubit(this.repo) : super(ProductInitial());

  Future<void> getProductDetails(String slug) async {
    emit(ProductLoading());

    try {
      final product = await repo.getProductDetails(slug);
      print("FETCHING PRODUC&&T");
      print("FETCHING PRODUCTéé");
      print("FETCHING PRODUCT""");
      print("FETCHING PRODU'''CT");
      emit(ProductSuccess(product));
    } catch (e) {
      emit(ProductError("No Internet"));
    }
  }
}