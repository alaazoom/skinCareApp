

// import 'package:ecommere2/data/status/removedStatus.dart';
// import 'package:ecommere2/logic/gettingData/addToCart.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RemoveCartCubit extends Cubit<RemoveCartState> {
//   final CartApi api;
//   final String token;
  

//   int? currentId;

//   RemoveCartCubit(
//     this.api,
//     this.token,
//   ) : super(RemoveCartInitial());

//   Future<void> removeProduct({
//     required int cartId,
//   }) async {
//     try {
//       print("========== REMOVE START ==========");
//       print("Cart ID: $cartId");

//       currentId = cartId;

//       emit(RemoveCartLoading());
//       print("State => RemoveCartLoading");

//       final result = await api.removeFromCart(
//         token: token,
//         cartId: cartId,
//       );

//       print("API RESPONSE => $result");

//       emit(
//         RemoveCartSuccess(
//           result["message"],
//         ),
//       );

//       print(
//         "State => RemoveCartSuccess : ${result["message"]}",
//       );

//       currentId = null;

//       print("========== REMOVE END ==========");

//     } catch (e) {

//       currentId = null;

//       print("ERROR => $e");

//       emit(
//         RemoveCartError(
//           e.toString(),
//         ),
//       );

//       print(
//         "State => RemoveCartError : $e",
//       );
//     }
//   }
// }




import 'package:ecommere2/data/status/removedStatus.dart';
import 'package:ecommere2/logic/gettingData/addToCart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveCartCubit extends Cubit<RemoveCartState> {
  final CartApi api;
  final String token;

  int? currentId;
  bool _handled = false;

  RemoveCartCubit(
    this.api,
    this.token,
  ) : super(RemoveCartInitial());

  Future<void> removeProduct({
    required int cartId,
  }) async {
    try {
      currentId = cartId;
      _handled = false;

      emit(RemoveCartLoading());
      final result = await api.removeFromCart(
        token: token,
        cartId: cartId,
      );


      if (!_handled) {
        _handled = true;


        emit(
          RemoveCartSuccess(
            result["message"] ?? "Removed successfully",
          ),
        );

        
      }

      currentId = null;

      print("========== REMOVE END ==========");
    } catch (e) {
      currentId = null;

      print("ERROR => $e");

      emit(
        RemoveCartError(e.toString()),
      );

      print("State => RemoveCartError : $e");
    }
  }
}