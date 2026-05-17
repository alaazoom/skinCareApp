import 'dart:convert';
import 'package:ecommere2/data/cubit/addToCart.dart';
import 'package:ecommere2/data/cubit/addressCubit.dart';
import 'package:ecommere2/data/cubit/allProductCubit.dart';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/cubit/favProductsCubot.dart';
import 'package:ecommere2/data/cubit/removedCartStatus.dart';
import 'package:ecommere2/data/cubit/userCubot.dart';
import 'package:ecommere2/logic/cache/userCache.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/addToCart.dart';
import 'package:ecommere2/logic/gettingData/favAPI.dart';
import 'package:ecommere2/logic/gettingData/getAllProducts.dart';
import 'package:ecommere2/logic/gettingData/getUser.dart';
import 'package:ecommere2/ui/screens/navigationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required var context,
    
  }) async {

    final url = Uri.parse(
      "https://tullana.toldpath.com/api/customer/auth/register",
    );

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "country_code": "ps",
        "password": password,
        "password_confirmation": passwordConfirmation,
        "agreed_with_terms": true,
      }),
    );

    final Map<String, dynamic> data =
        response.body.isNotEmpty ? jsonDecode(response.body) : {};

    print("STATUS: ${response.statusCode}");
    print("RESPONSE: $data");

    final token = data["token"]; // ✅ الصحيح حسب API عندك

    if (response.statusCode == 200 &&
        data["status"] == true &&
        token != null &&
        token.toString().isNotEmpty) {

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", token);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                      BlocProvider(
  create: (_) => RemoveCartCubit(
    CartApi("https://tullana.toldpath.com/api"),
    token,
  ),
),
//                       BlocProvider(
//   create: (_) => CartCubit2(
//     CartApi("https://tullana.toldpath.com/api"),
//     token,
//   ),
// ),

                    BlocProvider(
                      create: (_) => UserCubit(
                        api: UserApi("https://tullana.toldpath.com/api"),
                        local: UserLocalStorage(),
                      )..fetchUser(token!),
                    ),
     BlocProvider(
      create: (_) => CartCubit2(
        CartApi("https://tullana.toldpath.com/api"),
        token,
      )..getCart(),
    ),
                    BlocProvider(
                      create: (_) => ProductsCubit(
                        ProductsRepository(InternetChecker()),
                      )..getProducts(),
                    ),

                    BlocProvider(
                      create: (_) => FavCubit(
                        FavApi("https://tullana.toldpath.com/api"),
                        token!,
                      ),
                    ),

                    BlocProvider(
                      create: (context) => FavListCubit(
                        FavApi("https://tullana.toldpath.com/api"),
                        token!,
                        context.read<FavCubit>(),
                      )..getFavorites(),
                    ),
                        BlocProvider(
  create: (_) => AddressCubit()..getAddresses(),
),
  BlocProvider(
      create: (_) => CartCubit(
        CartApi("https://tullana.toldpath.com/api"),
        token,
      )),

                  ],
                  child: BottomNavScreen(token: token!),
                ),
              ),
              (route) => false,
            );

      return token;
    }

    String errorMessage = data["message"] ?? "Registration failed";

    if (data["errors"] != null) {
      Map<String, dynamic> errors = data["errors"];
      List<String> allErrors = [];

      errors.forEach((key, value) {
        if (value is List) {
          allErrors.addAll(List<String>.from(value));
        } else {
          allErrors.add(value.toString());
        }
      });

      errorMessage = allErrors.join("\n");
    }

    throw Exception(errorMessage);
  }
}