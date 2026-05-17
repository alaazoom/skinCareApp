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
import 'package:ecommere2/ui/screens/aboutusScreen.dart';
import 'package:ecommere2/ui/screens/auth/onBoarding1.dart';
import 'package:ecommere2/ui/screens/cartScreen.dart';
import 'package:ecommere2/ui/screens/contactUs.dart';
import 'package:ecommere2/ui/screens/favScreen.dart';
import 'package:ecommere2/ui/screens/home/home.dart';
import 'package:ecommere2/ui/screens/auth/Verificationscreen.dart';
import 'package:ecommere2/ui/screens/auth/forgotpassword.dart';
import 'package:ecommere2/ui/screens/auth/loginscreen.dart';
import 'package:ecommere2/ui/screens/auth/signup.dart';
import 'package:ecommere2/ui/screens/auth/splashscreen.dart';
import 'package:ecommere2/ui/screens/home/productDetailsScreen.dart';
import 'package:ecommere2/ui/screens/home/searchscreen.dart';
import 'package:ecommere2/ui/screens/navigationPage.dart';
import 'package:ecommere2/ui/screens/privacyScreen.dart';
import 'package:ecommere2/ui/screens/profile/addAddress.dart';
import 'package:ecommere2/ui/screens/profile/allAddresses.dart';
import 'package:ecommere2/ui/screens/profile/editProfile.dart';
import 'package:ecommere2/ui/screens/profile/profileScreen.dart';
import 'package:ecommere2/ui/screens/termsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  

  runApp(

     MyApp(),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 550),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: 
          

          
          
          
          
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final prefs = snapshot.data as SharedPreferences;
              final token = prefs.getString("token");

              if (token == null || token.isEmpty) {
                return const SplashScreen();
              }

              return MultiBlocProvider(
                providers: [
BlocProvider(
      create: (context) => UserCubit(
        api: UserApi("https://tullana.toldpath.com/api"),
        local: UserLocalStorage(),
      )..fetchUser(token), 
      
    ),
                  /// PRODUCTS
                  BlocProvider(
                    create: (context) => ProductsCubit(
                      ProductsRepository(InternetChecker()),
                    )..getProducts(),
                  ),

                  /// FAVORITES
                  BlocProvider(
                    create: (context) => FavCubit(
                      FavApi(
                        "https://tullana.toldpath.com/api",
                      ),
                      token,
                    ),
                  ),

                  /// FAVORITES LIST
                  BlocProvider(
                    create: (context) => FavListCubit(
                      FavApi(
                        "https://tullana.toldpath.com/api",
                      ),
                      token,
                      context.read<FavCubit>(),
                    )..getFavorites(),
                  ),
                  BlocProvider(
      create: (_) => CartCubit(
        CartApi("https://tullana.toldpath.com/api"),
        token,
      )
    ),

    BlocProvider(
  create: (_) => RemoveCartCubit(
    CartApi("https://tullana.toldpath.com/api"),
    token,
  ),
),
  BlocProvider(
      create: (_) => CartCubit2(
        CartApi("https://tullana.toldpath.com/api"),
        token,
      )..getCart()
    ),

  // BlocProvider(
  //     create: (_) => CartCubit2(
  //       CartApi("https://tullana.toldpath.com/api"),
  //       token,
  //     )..getCart()
  //   ),
  // BlocProvider(
  //     create: (_) => CartCubit2(
  //       CartApi("https://tullana.toldpath.com/api"),
  //       token,
  //     )..refreshCart()
  //   ),
  
    //      BlocProvider(
    //   create: (_) => CartCubit2(
    //     CartApi("https://tullana.toldpath.com/api"),
    //     token,
    //   )
    // ),



    BlocProvider(
  create: (_) => AddressCubit()..getAddresses(),
),

                ],

                child:
                //  SplashScreen()
                // AddAddressScreen()
                // DeliveryAddressScreen()
                
                BottomNavScreen(token: token ,),
              );
            },
          ),
        );
      },
    );
  }
}