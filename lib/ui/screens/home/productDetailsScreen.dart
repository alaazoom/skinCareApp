
import 'package:ecommere2/data/cubit/addToCart.dart';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/detailsCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/status/addToCartStatus.dart';
import 'package:ecommere2/data/status/detailsStatus.dart';
import 'package:ecommere2/data/status/favStatus.dart';
import 'package:ecommere2/logic/models/cartitemModel.dart';
import 'package:ecommere2/shimmer/produsctDetailsSShimmer.dart';
import 'package:ecommere2/ui/screens/home/searchscreen.dart';
import 'package:ecommere2/ui/widgets/animation.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
    final GlobalKey cartKey;

  final String slug;

  const ProductDetailsScreen({super.key, required this.slug, required this.cartKey});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>   with SingleTickerProviderStateMixin{
  int qty = 1;
final GlobalKey productKey = GlobalKey();

final Map<int, GlobalKey> productKeys = {};
late AnimationController pageController;
late Animation<double> scaleAnim;
late Animation<double> moveAnim;
  late FavCubit favCubit;
  
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
    favCubit = context.read<FavCubit>();


}
@override
void dispose() {
  super.dispose();
}
void flyToCartAndExit(GlobalKey cartKey) async {
  final overlay = Overlay.of(context);

final renderBox =
    productKey.currentContext!.findRenderObject()
        as RenderBox;
  final start = renderBox.localToGlobal(Offset.zero);

  final cartBox =
      cartKey.currentContext!.findRenderObject() as RenderBox;
  final end = cartBox.localToGlobal(Offset.zero);

  final entry = OverlayEntry(
    builder: (_) {
      return AnimatedFlyToCart(
        start: start,
        end: end,
      );
    },
  );

  overlay.insert(entry);

  await Future.delayed(const Duration(milliseconds: 600));

  entry.remove();

  if (mounted) {
    Navigator.pop(context);
  }
}



  @override
void initState() {
  super.initState();
  context.read<ProductDetailsCubit>().getProductDetails(widget.slug);
pageController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800), // زيادة المدة قليلاً ليكون التأثير ملحوظاً
  );

  // تصغير من الحجم الكامل إلى الصفر تقريباً
  scaleAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
    CurvedAnimation(parent: pageController, curve: Curves.easeInOutCubic),
  );

  // الحركة للأعلى وللجانب (نحو أيقونة السلة)
  moveAnim = Tween<double>(begin: 0.0, end: -1.0).animate(
    CurvedAnimation(parent: pageController, curve: Curves.easeInOutCubic),
  );
}
  double pageScale = 1.0;
double pageY = 0.0;

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
return BlocListener<CartCubit, CartState>(
  listenWhen: (prev, curr) => curr is CartSuccess,
  listener: (context, state) async{
    await context.read<CartCubit2>().getCart();
  },
  child: Scaffold(
        backgroundColor: const Color(0xffFAF8F5),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
      
            if (state is ProductLoading) {
              return  ProductDetailsShimmer();
            }
      
            if (state is ProductError) {
              return Center(child: Text(state.message));
            }
      
            if (state is ProductSuccess) {
              
              final product = state.product;
      
              final isFav = context.watch<FavCubit>().isFav(product.id);
              
      
              return SingleChildScrollView(
                child: StaggerItem(
                  index: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        
                      StaggerItem(
                        index: 0,
                        child: Stack(
                          children: [
                                          
                              Hero(
                                tag: product.id,
                                child: Container(
                                          key: productKey,
                                  child: Image.network(
                                                       
                                  product.thumbnail,
                                  width: 390.w,
                                  height: 250.h,
                                  fit: BoxFit.cover,
                                        
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                        
                                    return SizedBox(
                                      width: 390.w,
                                      height: 250.h,
                                      child: const Center(
                                        child: CircularProgressIndicator(color: Colors.grey,),
                                      ),
                                    );
                                  },
                                        
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "images/logo.png",
                                      width: 390.w,
                                      height: 250.h,
                                      fit: BoxFit.contain,
                                    );
                                  },
                                                          ),
                                ),
                              ),
                            Positioned(
                              top: 24.h,
                              left: 24.w,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: _icon(Icons.arrow_back),
                              ),
                            ),
                          Positioned(
                            top: 24.h,
                            right: 24.w,
                            child: BlocConsumer<FavCubit, FavState>(
                          listener: (context, state) {
                          
                            void showTopSnackBar(
                              BuildContext context,
                              String message,
                              Color color,
                            ) {
                              final overlay = Overlay.of(context);
                          
                              final entry = OverlayEntry(
                                builder: (context) => Positioned(
                                  top: 40.h,
                                  left: 24.w,
                                  right: 24.w,
                                  child: Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                                            padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                                            ),
                                            decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                                            ),
                                            child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                                            ),
                                          ),
                                  ),
                                ),
                              );
                          
                              overlay.insert(entry);
                          
                              Future.delayed(
                                const Duration(seconds: 2),
                                () => entry.remove(),
                              );
                            }
                          
                            if (state is FavSuccess) {
                              showTopSnackBar(
                                context,
                                state.message,
                                const Color(0xff5C6B4A),
                              );
                            }
                          
                            if (state is FavError) {
                              showTopSnackBar(
                                context,
                                state.message,
                                Colors.red,
                              );
                            }
                          },
                          
                          builder: (context, state) {
                          
                            final isFav =
                                context.watch<FavCubit>().isFav(product.id);
                          
                            return GestureDetector(
                              onTap: () {
                                context
                                          .read<FavCubit>()
                                          .toggleFav(product.id);
                              },
                          
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                          
                                child: Icon(
                                  isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                          
                                  color:
                                            isFav ? Colors.red : Colors.grey,
                          
                                  size: 22.sp,
                                ),
                              ),
                            );
                          },
                            ),
                          ),
                          ],
                        ),
                      ),
                        
                      Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            StaggerItem(
                                index: 1,
                              child: Row(
                                children: [
                                  Hero(
                                     tag: "name${product.id}",
                                    child: MyText(
                                      text: product.name,
                                      size: 24.sp,
                                      thisfontWeight: FontWeight.w500,
                                      textColor: const Color(0xff2C2C2C),
                                    ),
                                  ),
                                  const Spacer(),
                                  Hero(
                                    tag: "price${product.id}",
                                    child: MyText(
                                      text: "\$${product.price}",
                                      size: 24.sp,
                                      thisfontWeight: FontWeight.w400,
                                      textColor: const Color(0xff2C2C2C),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        
                            SizedBox(height: 5.h),
                        
                            Row(
                              children: [
                                MyText2(
                                  text: "★",
                                  size: 18.sp,
                                  thisfontWeight: FontWeight.w500,
                                  textColor: const Color(0xffC9B896),
                                ),
                                SizedBox(width: 3.w),
                                MyText2(
                                  text: "4.8 (124)",
                                  size: 13.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff8B8B8B),
                                )
                              ],
                            ),
                        
                            SizedBox(height: 12.h),
                        
                            StaggerItem(
                              index: 2,
                              child: MyText2(
                                text: product.shortDescription,
                                size: 16.sp,
                                thisfontWeight: FontWeight.w400,
                                textColor: const Color(0xff2C2C2C),
                                textAlign: TextAlign.start,
                              ),
                            ),
                        
                            SizedBox(height: 12.h),
                        
                            MyText2(
                              text: "DESCRIPTION",
                              size: 14.sp,
                              thisfontWeight: FontWeight.w500,
                              textColor: const Color(0xff8B8B8B),
                            ),
                        
                            SizedBox(height: 8.h),
                        
                            StaggerItem(
                              index: 3,
                              child: MyText2(
                                textAlign: TextAlign.start,
                                                      
                                text: product.details
                                    .replaceAll(RegExp(r'<[^>]*>'), ''),
                                size: 16.sp,
                                thisfontWeight: FontWeight.w400,
                                textColor: const Color(0xff2C2C2C),
                              ),
                            ),
                        
                            SizedBox(height: 12.h),
                        
                            MyText2(
                              text: "KEY INGREDIENTS",
                              size: 14.sp,
                              thisfontWeight: FontWeight.w500,
                              textColor: const Color(0xff8B8B8B),
                            ),
                        
                            StaggerItem(
                              index:4,
                              child: KeywordsWidget2(keywords: product.tags)),
                        
                            SizedBox(height: 12.h),
                        
                            MyText2(
                              text: "BENEFITS",
                              size: 14.sp,
                              thisfontWeight: FontWeight.w500,
                              textColor: const Color(0xff8B8B8B),
                            ),
                        
                            SizedBox(height: 8.h),
                        
                            StaggerItem(
                              index: 5,
                              child: MyText2(
                                text:
                                    "• Brightens skin tone\n• Reduces dark spots\n• Hydrates deeply\n• Improves texture",
                                size: 16.sp,
                                thisfontWeight: FontWeight.w400,
                                textColor: const Color(0xff2C2C2C),
                                textAlign: TextAlign.start,
                              ),
                            ),
                        
                            SizedBox(height: 12.h),
                        
                            MyText2(
                              text: "HOW TO USE",
                              size: 14.sp,
                              thisfontWeight: FontWeight.w500,
                              textColor: const Color(0xff8B8B8B),
                            ),
                        
                            SizedBox(height: 8.h),
                        
                            StaggerItem(
                              index: 6,
                              child: MyText2(
                                text:
                                    "Apply 2-3 drops to clean, dry skin morning and evening. Follow with moisturizer.",
                                size: 16.sp,
                                thisfontWeight: FontWeight.w400,
                                textColor: const Color(0xff2C2C2C),
                                textAlign: TextAlign.start,
                              ),
                            ),
                        
                            SizedBox(height: 12.h),
                        
                            MyText2(
                              text: "QUANTITY",
                              size: 14.sp,
                              thisfontWeight: FontWeight.w500,
                              textColor: const Color(0xff8B8B8B),
                            ),
                        
                            SizedBox(height: 8.h),
                        
                            StaggerItem(
                              index: 7,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (qty > 1) setState(() => qty--);
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffF5F1EB),
                                      ),
                                      child: Center(child: MyText2(text: "-", size: 24.sp, thisfontWeight: FontWeight.w500, textColor: const Color(0xff2C2C2C))),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  MyText2(text: "$qty", size: 25.sp, thisfontWeight: FontWeight.w400, textColor: const Color(0xff2C2C2C)),
                                  SizedBox(width: 12.w),
                                  GestureDetector(
                                    onTap: () => setState(() => qty++),
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffF5F1EB),
                                      ),
                                      child: Center(child: MyText2(text: "+", size: 22.sp, thisfontWeight: FontWeight.w500, textColor: const Color(0xff2C2C2C))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        
                            SizedBox(height: 16.h),
                        BlocConsumer<CartCubit, CartState>(
  listener: (context, state) async {
    if (state is CartSuccess) {
      // خلي علامة الصح تبين شوي
      await Future.delayed(const Duration(milliseconds: 900));

      if (mounted) {
        Navigator.pop(context, true);
      }
    }

    if (state is CartError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  builder: (context, state) {
    return InkWell(
      onTap: state is CartLoading
          ? null
          : () {
              context.read<CartCubit>().addToCart(
                    productId: product.id,
                    quantity: qty,
                  );
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff5C6B4A),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.3, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },

            // ================= STATES =================

            child: state is CartLoading
                ? Row(
                    key: const ValueKey("loading"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 400),
                        offset: const Offset(-0.2, 0),
                        child: MyText2(
                          text: "Adding...",
                          size: 18.sp,
                          thisfontWeight: FontWeight.w500,
                          textColor: Colors.white,
                        ),
                      ),

                      SizedBox(width: 12.w),

                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.7, end: 1),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  )

                // SUCCESS
                : state is CartSuccess
                    ? Row(
                        key: const ValueKey("success"),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),

                          SizedBox(width: 8.w),

                          MyText2(
                            text: "Added",
                            size: 18.sp,
                            thisfontWeight: FontWeight.w500,
                            textColor: Colors.white,
                          ),
                        ],
                      )

                    // DEFAULT
                    : Row(
                        key: const ValueKey("default"),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/Icon.png",
                            height: 24,
                            width: 24,
                          ),

                          SizedBox(width: 8.w),

                          MyText2(
                            text: "Add to Cart",
                            size: 20.sp,
                            thisfontWeight: FontWeight.w400,
                            textColor: const Color(0xffFFFFFF),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  },
),
                         
                        
                  //           BlocConsumer<CartCubit, CartState>(
                  //         listener: (context, state) async {
                  //         if (state is CartSuccess) {
                  
                  
                  //   if (!mounted) return;
                  //   await Future.delayed(const Duration(milliseconds: 600));
                  // if (mounted) {
                  //   Navigator.pop(context, true);
                  // }
                  
                  //   // flyToCartAndExit(widget.cartKey);
                  //   }
                  
                  //   if (state is CartError) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text(state.message),
                  //         backgroundColor: Colors.red,
                  //       ),
                  //     );       
                  
                        
                        
                  //         }
                        
                  //       if (state is CartError) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //             content: Text(state.message),
                  //             backgroundColor: Colors.red,
                  //           ),
                  //         );
                  //       }
                  //         },
                        
                  //         builder: (context, state)   {
                  //       return  InkWell(
                  //         onTap : () async{
                  //           context.read<CartCubit>().addToCart(
                  // productId: product.id,
                  // quantity: qty,
                  //               );
                        
                  //         },
                  //         child: StaggerItem(
                  //           index: 8,
                  //           child: Container(
                  //                 height: 40.h,
                  //                 width: double.infinity,
                  //                 decoration: BoxDecoration(
                  //                   color: const Color(0xff5C6B4A),
                  //                   borderRadius: BorderRadius.circular(9999),
                  //                 ),
                  //                 child:
                  //                 state is CartLoading?
                                  
                                  
                  //                 Center(
                  //                                 child:CircularProgressIndicator(color: Colors.white,)
                  //                               ):
                                  
                  //                  Center(
                  //                   child: Row(
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //                       Image.asset("images/Icon.png", height: 24, width: 24),
                  //                       SizedBox(width: 8.w),
                  //                       MyText2(
                  //                         text: "Add to Cart",
                  //                         size: 20.sp,
                  //                         thisfontWeight: FontWeight.w400,
                  //                         textColor: const Color(0xffFFFFFF),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //         ),
                  //       );
                            
                  //         },
                  //       ),
                        
                            SizedBox(height: 16.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
      
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, size: 20.sp),
    );
  }
}

class KeywordsWidget2 extends StatelessWidget {
  final List<String> keywords;

  const KeywordsWidget2({super.key, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 5.w,
        runSpacing: 5.h,
        children: keywords.map((word) => _buildKeywordItem(word)).toList(),
      ),
    );
  }

  Widget _buildKeywordItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 217, 181),
        borderRadius: BorderRadius.circular(5000),
      ),
      child: Text(text),
    );
  }
}




class StaggerItem extends StatefulWidget {
  final Widget child;
  final int index;

  const StaggerItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<StaggerItem> createState() => _StaggerItemState();
}

class _StaggerItemState extends State<StaggerItem> {
  double opacity = 0;
  double offset = 25;

  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index;

    Future.delayed(Duration(milliseconds: index * 120), () {
      if (!mounted) return;

      setState(() {
        opacity = 1;
        offset = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 👇 مدة الأنيميشن تزيد مع كل عنصر
    final duration = Duration(milliseconds: 300 + (index * 120));

    return AnimatedOpacity(
      duration: duration,
      curve: Curves.easeOut,
      opacity: opacity,
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, offset, 0),
        child: widget.child,
      ),
    );
  }
}