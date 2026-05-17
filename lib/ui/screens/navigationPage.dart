
import 'package:ecommere2/data/cubit/addressCubit.dart';
import 'package:ecommere2/data/cubit/allProductCubit.dart';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/cubit/favProductsCubot.dart';
import 'package:ecommere2/data/cubit/userCubot.dart';
import 'package:ecommere2/logic/cache/userCache.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/addToCart.dart';
import 'package:ecommere2/logic/gettingData/favAPI.dart';
import 'package:ecommere2/logic/gettingData/getAllProducts.dart';
import 'package:ecommere2/logic/gettingData/getUser.dart';
import 'package:ecommere2/ui/screens/aboutusScreen.dart';
import 'package:ecommere2/ui/screens/cartScreen.dart';
import 'package:ecommere2/ui/screens/contactUs.dart';
import 'package:ecommere2/ui/screens/favScreen.dart';
import 'package:ecommere2/ui/screens/home/home.dart';
import 'package:ecommere2/ui/screens/privacyScreen.dart';
import 'package:ecommere2/ui/screens/profile/allAddresses.dart';
import 'package:ecommere2/ui/screens/profile/profileScreen.dart';
import 'package:ecommere2/ui/screens/termsScreen.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavScreen extends StatefulWidget {
  final String token;

  const BottomNavScreen({super.key, required this.token});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  bool isDrawerOpen = false;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  void openDrawer() {
    setState(() {
      xOffset = 250;
      yOffset = 90;
      scaleFactor = 0.72;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  void toggleDrawer() {
    if (isDrawerOpen) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  List<Widget> get pages => [
        HomeScreen(onMenuTap: toggleDrawer),
        FavouriteScreen(),
        CartScreen(),
        ProfileScreen(),
      ];
      @override
  void initState() {

    print(")0000000000000000000000000");
    print(widget.token+"++");
    print(widget.token+"=====");
    print(")0000000000000000000000000");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsCubit(
            ProductsRepository(InternetChecker()),
          )..getProducts(),
        ),

        
BlocProvider.value(
  value: context.read<FavCubit>(),
),
          BlocProvider.value(
  value: context.read<FavListCubit>(),
),
      ],
      child: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0xff5C6B4A).withOpacity(.5),

        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                top: 90,
              ),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  
                  Image.asset("images/logo.png",height: 100,width: 100,),
                  SizedBox(height:10.h),
                  MyText(text: "N A T U R A L  \nB E A U T Y",
                   size: 18.sp, thisfontWeight: FontWeight.w900,
                    textColor: Colors.white),
                  // SizedBox(height:2.h),
                  MyText(text: "since 2020",
                   size: 21.sp, thisfontWeight: FontWeight.w400,
                    textColor: Colors.white.withOpacity(.7)),
                     SizedBox(height:8.h),
                  InkWell(
                    
                    onTap:() async{ 
                      Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MultiBlocProvider(
                providers: [
BlocProvider(
      create: (context) => UserCubit(
        api: UserApi("https://tullana.toldpath.com/api"),
        local: UserLocalStorage(),
      )..fetchUser(widget.token), 
      
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
                      widget.token,
                    ),
                  ),
                     BlocProvider(
      create: (_) => CartCubit2(
        CartApi("https://tullana.toldpath.com/api"),
        widget.token,
      )..getCart(),
    ),

                  /// FAVORITES LIST
                  BlocProvider(
                    create: (context) => FavListCubit(
                      FavApi(
                        "https://tullana.toldpath.com/api",
                      ),
                      widget.token,
                      context.read<FavCubit>(),
                    )..getFavorites(),
                  ),
                ],

                child:
                
                
                 BottomNavScreen(token: widget.token ,),
              ),
                  ),
                );
                
                },
                    child: menuItem("Home")),
                    menuItem("History"),
                InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AddressCubit()..getAddresses(),
          child:  DeliveryAddressScreen(),
        ),
      ),
    );
  },
  child: menuItem("Address"),
),
                  // menuItem("New Address"),
                  
                  const SizedBox(height: 6),
                  InkWell(
                    
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                    },
                    child: subMenuItem("About Us")),
                  InkWell(
                       onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsScreen()));
                    },
                    
                    child: subMenuItem("Our Terms")),
                  InkWell(
                       onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyScreen()));
                    },
                    
                    child: subMenuItem("Privacy Policy")),
                  InkWell(
                      
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactusScreen()));
                    },
                    
                    child: subMenuItem("Contact Us")),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                xOffset,
                yOffset,
                0,
              )..scale(scaleFactor),
              decoration: BoxDecoration(
                color: const Color(0xffF7F5F2),
                borderRadius: BorderRadius.circular(
                  isDrawerOpen ? 40 : 0,
                ),
                boxShadow: [
                  if (isDrawerOpen)
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 20,
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  isDrawerOpen ? 40 : 0,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (isDrawerOpen) closeDrawer();
                  },
                  child: AbsorbPointer(
                    absorbing: isDrawerOpen,
                    child: Scaffold(
                      backgroundColor: const Color(0xffF7F5F2),
                      body: pages[currentIndex],
                      bottomNavigationBar: Container(
                        height: 75,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [
                            navItem(
                              icon: Icons.home_outlined,
                              label: "Home",
                              index: 0,
                            ),
                            navItem(
                              icon: Icons.favorite_border,
                              label: "Favorites",
                              index: 1,
                            ),
                            navItem(
                              icon: Icons.shopping_bag_outlined,
                              label: "Shop",
                              index: 2,
                            ),
                            navItem(
                              icon: Icons.person_outline,
                              label: "Profile",
                              index: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected
                ? const Color(0xff6E7F52)
                : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isSelected
                  ? const Color(0xff6E7F52)
                  : Colors.grey,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget subMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child:  MyText2(text: title, size: 16, thisfontWeight: FontWeight.w400,
       textColor: Colors.white70)
    );
  }
}