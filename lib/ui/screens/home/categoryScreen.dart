// import 'package:ecommere2/ui/screens/home/card1.dart';
// import 'package:ecommere2/ui/screens/home/productDetailsScreen.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {

//   int selectedIndex = 0;

//   List<String> categories = [
//     "All",
//     "Serums",
//     "Moisturizers",
//     "Cleansers",
//     "Masks",
//   ];

//   List<Map<String, dynamic>> products = [
//     {
//       "name": "Vitamin C Serum",
//       "category": "Serums",
//     },
//     {
//       "name": "Hydrating Cream",
//       "category": "Moisturizers",
//     },
//     {
//       "name": "Face Wash",
//       "category": "Cleansers",
//     },
//     {
//       "name": "Night Mask",
//       "category": "Masks",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {

//     String selectedCategory = categories[selectedIndex];

//     List filteredProducts =
//         selectedCategory == "All"
//             ? products
//             : products.where((item) {
//                 return item["category"] == selectedCategory;
//               }).toList();

//     return Column(
//         children: [

//           /// Categories
//           SizedBox(
//             height: 28.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {

//                 bool isSelected = selectedIndex == index;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 8.w),
//                     padding: EdgeInsets.symmetric(horizontal:12.h),
//                     decoration: BoxDecoration(
//                       color:
//                           isSelected
//                               ? Color(0xff5C6B4A)
//                               : Color(0xffF5F1EB),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       categories[index],
//                       style: TextStyle(
//                         color:
//                             isSelected
//                                 ? Color(0xffFFFFFF)
//                                 : Color(0xff8B8B8B),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           GridView.builder(
//              shrinkWrap: true, 
//           physics: NeverScrollableScrollPhysics(), 
//             itemCount: filteredProducts.length,
//             // padding: EdgeInsets.all(16),
//             gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10.h,
//               crossAxisSpacing: 14.w,
//               childAspectRatio: 0.57
//             ),
//             itemBuilder: (context, index) {
          
//               var product = filteredProducts[index];
          
//               return InkWell(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen()));
//                 },
//                 child: ProductCard(image: "images/Radiance Skin Serum.png", name: product["name"], price: "\$48.00"));
            
//             },
//           ),
//         ],
      
//     );
//   }
// }








import 'package:ecommere2/data/cubit/addToCart.dart';
import 'package:ecommere2/data/cubit/allProductCubit.dart';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/detailsCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/status/allproductsStatus.dart';
import 'package:ecommere2/data/cubit/favProductsCubot.dart';
import 'package:ecommere2/logic/gettingData/addToCart.dart';
import 'package:ecommere2/logic/gettingData/favAPI.dart';
import 'package:ecommere2/logic/gettingData/getDetails.dart';
import 'package:ecommere2/shimmer/productShimmer.dart';
import 'package:ecommere2/ui/screens/home/card1.dart';
import 'package:ecommere2/ui/screens/home/productDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  final GlobalKey cartKey;
  const CategoryScreen({super.key, required this.cartKey});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = 0;
  
Future<void> openProductDetails(
  BuildContext context,
  String slug,
) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),

    pageBuilder: (_, __, ___) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductDetailsCubit(ProductDetailsRepository()),
        ),
        BlocProvider(
          create: (context) =>
              CartCubit2(CartApi("https://tullana.toldpath.com/api"), token!),
        ),
        BlocProvider.value(
          value: context.read<FavListCubit>(),
        ),
        BlocProvider.value(
          value: context.read<FavCubit>(),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            CartApi("https://tullana.toldpath.com/api"),
            token!,
          ),
        ),
      ],
      child: ProductDetailsScreen(
        slug: slug,
        cartKey: widget.cartKey,
      ),
    ),

    transitionsBuilder: (_, animation, __, child) {
      final scale = Tween<double>(
        begin: 0.95,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
      );

      return ScaleTransition(
        scale: scale,
        child: child,
      );
    },
  ),
);
}
  List<String> categories = [
    "All",
    "Serums",
    "Moisturizers",
    "Cleansers",
    "Masks",
  ];
@override
void initState() {
  super.initState();
  context.read<ProductsCubit>().getProducts();
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 28.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xff5C6B4A)
                        : Color(0xffF5F1EB),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: isSelected
                          ? Color(0xffFFFFFF)
                          : Color(0xff8B8B8B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 16.h),

        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const ProductShimmer();
            }

            if (state is ProductsError) {
              return Center(
                child: Column(
                  children: [
                    const Icon(Icons.wifi_off, size: 50),
                    SizedBox(height: 10.h),
                    Text(state.message),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductsCubit>().getProducts();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }
            if (state is ProductsSuccess) {
  final products = state.products;

  final selectedCategory = categories[selectedIndex];

  String normalize(String text) {
    return text
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r's$'), '');
  }

  final filteredProducts = selectedCategory == "All"
      ? products
      : products.where((product) {
          final productName = normalize(product.name);
          final categoryName = normalize(selectedCategory);

          return productName.contains(categoryName);
        }).toList();

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: filteredProducts.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 14.w,
      childAspectRatio: 0.48,
    ),
    itemBuilder: (context, index) {
      final product = filteredProducts[index];

      return InkWell(
        onTap: () {
  openProductDetails(context, product.slug);
},
       
        child: ProductCard(
          product: product,
          image: product.images[0],
          name: product.name,
          price: "\$${product.purchasePrice}",
        ),
      );
    },
  );
}

            // if (state is ProductsSuccess) {
            //   final products = state.products;

            //   return GridView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: products.length,
            //     gridDelegate:
            //         SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 10.h,
            //       crossAxisSpacing: 14.w,
            //       childAspectRatio: 0.57,
            //     ),
            //     itemBuilder: (context, index) {
            //       final product = products[index];

            //       return InkWell(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) =>
            //                   ProductDetailsScreen(),
            //             ),
            //           );
            //         },
            //         child: ProductCard(
            //           image: product.images[0],
            //           name: product.name,
            //           price: "\$${product.purchasePrice}",
            //         ),
            //       );
            //     },
            //   );
            // }


// 

            return const SizedBox();
          },
        ),
      ],
    );
  }
}