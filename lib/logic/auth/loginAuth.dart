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

class LoginService {

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {

    final url = Uri.parse(
      "https://tullana.toldpath.com/api/customer/auth/login",
    );

    try {

      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      Map<String, dynamic> data = {};

      if (response.body.isNotEmpty) {
        data = jsonDecode(response.body);
      }

      if (data["status"] == true) {

        String? token = data["token"]; // ✅ الصحيح

        if (token != null && token.isNotEmpty) {

          final prefs = await SharedPreferences.getInstance();

          await prefs.setString("token", token);

          await prefs.reload();

         Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                        BlocProvider(
  create: (_) => AddressCubit()..getAddresses(),
),
  BlocProvider(
      create: (_) => CartCubit(
        CartApi("https://tullana.toldpath.com/api"),
        token,
      )),

                    BlocProvider(
                      create: (_) => UserCubit(
                        api: UserApi("https://tullana.toldpath.com/api"),
                        local: UserLocalStorage(),
                      )..fetchUser(token!),
                    ),

                    BlocProvider(
                      create: (_) => ProductsCubit(
                        ProductsRepository(InternetChecker()),
                      )..getProducts(),
                    ),
                      BlocProvider(
  create: (_) => RemoveCartCubit(
    CartApi("https://tullana.toldpath.com/api"),
    token,
  ),
),
//   BlocProvider(
//   create: (_) => CartCubit2(
//     CartApi("https://tullana.toldpath.com/api"),
//     token,
//   ),
// ),

                    BlocProvider(
                      create: (_) => FavCubit(
                        FavApi("https://tullana.toldpath.com/api"),
                        token!,
                      ),
                    ),
     BlocProvider(
      create: (_) => CartCubit2(
        CartApi("https://tullana.toldpath.com/api"),
        token,
      )..getCart(),
    ),
                    BlocProvider(
                      create: (context) => FavListCubit(
                        FavApi("https://tullana.toldpath.com/api"),
                        token!,
                        context.read<FavCubit>(),
                      )..getFavorites(),
                    ),

                  ],
                  child: BottomNavScreen(token: token!),
                ),
              ),
              (route) => false,
            );

        } else {
          _showTopSnackBar(
            context,
            message: "Token not found in response",
            isSuccess: false,
          );
        }

      } else {

        String errorMessage =
            data["message"] ?? "Login failed";

        // التعامل مع errors (List أو Map)
        if (data["errors"] != null) {

          if (data["errors"] is List) {

            List errors = data["errors"];

            List<String> allErrors = [];

            for (var error in errors) {
              if (error["message"] != null) {
                allErrors.add(error["message"].toString());
              }
            }

            if (allErrors.isNotEmpty) {
              errorMessage = allErrors.join("\n");
            }

          } else if (data["errors"] is Map) {

            Map errors = data["errors"];

            List<String> allErrors = [];

            errors.forEach((key, value) {
              if (value is List) {
                allErrors.addAll(List<String>.from(value));
              }
            });

            if (allErrors.isNotEmpty) {
              errorMessage = allErrors.join("\n");
            }
          }
        }

        _showTopSnackBar(
          context,
          message: errorMessage,
          isSuccess: false,
        );
      }

    } catch (e) {

      _showTopSnackBar(
        context,
        message: "Something went wrong",
        isSuccess: false,
      );
    }
  }

  void _showTopSnackBar(
    BuildContext context, {
    required String message,
    required bool isSuccess,
  }) {

    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: isSuccess ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  isSuccess
                      ? Icons.check_circle_outline
                      : Icons.error_outline,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }
}