import 'package:ecommere2/data/status/cartStatus..dart';
import 'package:ecommere2/logic/gettingData/addToCart.dart';
import 'package:ecommere2/logic/models/cartitemModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit2  extends Cubit<AllCartState> {
  final CartApi api;
  final String token;

  CartCubit2(this.api, this.token) : super(CartInitial()){print("CART CUBIT CREATED 👉 $hashCode");}
  
void debugState() {
  print("CART STATE = $state");
}
Future<void> getCart() async {
  try {
    final res = await api.getCart(token);

    emit(
      CartLoaded(
        List<CartItem>.from(res.items),
        res.details,
      ),
    );

    print("CART UPDATED => ${res.items.length}");
  } catch (e) {
    emit(CartError(e.toString()));
  }
}
  
}