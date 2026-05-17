// import 'dart:developer';
// import 'package:ecommere2/data/status/addToCartStatus.dart';
// import 'package:ecommere2/data/status/cartStatus..dart' show CartRemoveSuccess;
// import 'package:ecommere2/logic/gettingData/addToCart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CartCubit extends Cubit<CartState> {
//   final CartApi api;
//   final String token;

//   CartCubit(this.api, this.token) : super(CartInitial());

//   Future<void> addToCart({
//     required int productId,
//     required int quantity,
//   }) async {
//     emit(CartLoading());

//     try {
//       log(" ADD TO CART REQUEST");
//       log("Product ID: $productId");
//       log("Quantity: $quantity");
//       log("Token: $token");

//       final response = await api.addToCart(
//         token: token,
//         productId: productId,
//         quantity: quantity,
//       );

//       log(" RAW RESPONSE: $response");

//       final status = response["status"];
//       final message = response["message"];

//       log("STATUS: $status");
//       log("MESSAGE: $message");
// if (status == true) {
//   log("SUCCESS ADD TO CART");
//   emit(CartSuccess(message));
// }
// if (status == 1) {
//   log("SUCCESS ADD TO CART");
//   emit(CartSuccess(message));
// }

// else if (status == 0) {
//   log("STATUS 0 CASE");

//   if (message.toLowerCase().contains("already")) {
//     log("ALREADY IN CART");
//     emit(CartError("Already in your cart"));
//   } 
//   else if (message.toLowerCase().contains("stock") ||
//            message.toLowerCase().contains("out")) {
//     log("OUT OF STOCK");
//     emit(CartError("out of stock"));
//   } 
//   else {
//     log("GENERIC STATUS 0");
//     emit(CartError(message));
//   }
// }

// else if (status == false) {
//   log("BUSINESS ERROR");
//   emit(CartError(message));
// }

//     } catch (e, stack) {
//       log(" CART ERROR OCCURRED");
//       log("ERROR: $e");
//       log("STACKTRACE: $stack");

//       emit(CartError(e.toString()));
//     }
//   }


// }






import 'dart:developer';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/status/addToCartStatus.dart';
import 'package:ecommere2/logic/gettingData/addToCart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartApi api;
  final String token;

  Set<int> loadingItems = {};

  CartCubit(this.api, this.token) : super(CartInitial());

  Future<void> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      loadingItems.add(productId);
      emit(CartLoadingItem(productId));

      log("ADD TO CART REQUEST");
      log("Product ID: $productId");
      log("Quantity: $quantity");

      final response = await api.addToCart(
        token: token,
        productId: productId,
        quantity: quantity,
      );

      log("RAW RESPONSE: $response");

      final status = response["status"];
      final message = response["message"] ?? "";

      if (status == true || status == 1  )  {
        log("SUCCESS ADD TO CART");
        
        emit(CartSuccess(message));
        print("ADD SUCCESS");
         
      } else {
        if (message.toString().toLowerCase().contains("already")) {
          emit(CartError("Already in your cart"));
        } else if (message.toString().toLowerCase().contains("stock") ||
            message.toString().toLowerCase().contains("out")) {
          emit(CartError("Out of stock"));
        } else {
          emit(CartError(message.toString()));
        }
      }
    } catch (e, stack) {
      log("CART ERROR: $e");
      log("STACK: $stack");

      emit(CartError(e.toString()));
    } finally {
      loadingItems.remove(productId);
      
    }
  }
}