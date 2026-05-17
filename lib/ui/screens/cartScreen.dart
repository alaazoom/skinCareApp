
// import 'package:ecommere2/data/cubit/addToCart.dart';
// import 'package:ecommere2/data/cubit/cartCubit.dart';
// import 'package:ecommere2/data/cubit/removedCartStatus.dart';
// import 'package:ecommere2/data/status/cartStatus..dart';
// import 'package:ecommere2/data/status/removedStatus.dart';
// import 'package:ecommere2/logic/models/cartitemModel.dart';
// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     context.read<CartCubit2>().getCart();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CartCubit2>().getCart();
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFAF8F5),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFAF8F5),
//         title: MyText(
//           text: "Shopping Cart",
//           size: 24.sp,
//           thisfontWeight: FontWeight.w500,
//           textColor: const Color(0xff2C2C2C),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: BlocBuilder<CartCubit2, AllCartState>(
//           builder: (context, state) {
//             if (state is CartLoading) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                 color: Colors.grey,
//               ));
//             }

//             if (state is CartError) {
//               return Center(child: Text(state.message));
//             }

//             if (state is CartLoaded) {
//               final items = state.items;
//               final details = state.details;

//               if (items.isEmpty) {
//                 return Center(
//                   child: MyText(
//                     text: "Your cart is empty\nStart Shopping Now",
//                     size: 18.sp,
//                     thisfontWeight: FontWeight.w500,
//                     textColor: Colors.grey.shade800,
//                   ),
//                 );
//               }

//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 10.h),
//                     ...List.generate(items.length, (index) {
//                       // استخدام ValueKey لضمان تتبع حالة العنصر أثناء الحذف والأنيميشن المعاكس
//                       return SideStaggerItem(
//                         key: ValueKey(items[index].id),
//                         index: index,
//                         itemId: items[index].id,
//                         child: ProductCart(item: items[index]),
//                       );
//                     }),

//                     // ...items.map((e) => ProductCart(item: e)),

//                     SizedBox(height: 24.h),

//                     Container(
//                       padding: EdgeInsets.all(20.w),
//                       width: double.infinity,
//                       height: 150.h,
//                       decoration: BoxDecoration(
//                         color: const Color(0xffFFFFFF),
//                         borderRadius: BorderRadius.circular(24.r),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           MyText(
//                             text: "Order Summary",
//                             size: 18.sp,
//                             thisfontWeight: FontWeight.w500,
//                             textColor: const Color(0xff2C2C2C),
//                           ),
//                           SizedBox(height: 16.h),
//                           Row(
//                             children: [
//                               MyText2(
//                                 text: "Subtotal",
//                                 size: 16.sp,
//                                 thisfontWeight: FontWeight.w400,
//                                 textColor: const Color(0xff2C2C2C),
//                               ),
//                               const Spacer(),
//                               MyText2(
//                                 text: "\$${details.subTotal}",
//                                 size: 16.sp,
//                                 thisfontWeight: FontWeight.w400,
//                                 textColor: const Color(0xff2C2C2C),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 7.h),
//                           Row(
//                             children: [
//                               MyText2(
//                                 text: "Shipping",
//                                 size: 16.sp,
//                                 thisfontWeight: FontWeight.w400,
//                                 textColor: const Color(0xff2C2C2C),
//                               ),
//                               const Spacer(),
//                               MyText2(
//                                 text: "\$${details.deliveryFee}",
//                                 size: 16.sp,
//                                 thisfontWeight: FontWeight.w400,
//                                 textColor: const Color(0xff2C2C2C),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 9.h),
//                           Divider(
//                               color: const Color(0xff5C6B4A).withOpacity(.15)),
//                           SizedBox(height: 9.h),
//                           Row(
//                             children: [
//                               MyText2(
//                                 text: "Total",
//                                 size: 16.sp,
//                                 thisfontWeight: FontWeight.w400,
//                                 textColor: const Color(0xff2C2C2C),
//                               ),
//                               const Spacer(),
//                               MyText(
//                                 text: "\$${details.totalCost}",
//                                 size: 22.sp,
//                                 thisfontWeight: FontWeight.w400,
//                                 textColor: const Color(0xff2C2C2C),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: 24.h),

//                     Mybutton(text: "Proceed to Checkout", s: 20, h: 38),

//                     SizedBox(height: 44.h),
//                   ],
//                 ),
//               );
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }

// class ProductCart extends StatefulWidget {
//   final CartItem item;

//   const ProductCart({
//     super.key,
//     required this.item,
//   });

//   @override
//   State<ProductCart> createState() => _ProductCartState();
// }

// class _ProductCartState extends State<ProductCart> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5.h),
//       height: 90.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: const Color(0xffFFFFFF),
//         borderRadius: BorderRadius.circular(24.r),
//       ),
//       padding: EdgeInsets.all(16.w),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(24.r),
//             child: Image.network(
//               widget.item.image ?? "",
//               height: 80.h,
//               width: 90.w,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   height: 80.h,
//                   width: 90.w,
//                   color: Colors.grey.shade200,
//                   child: const Icon(Icons.image_not_supported),
//                 );
//               },
//             ),
//           ),

//           SizedBox(width: 16.w),

//           // Info
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyText2(
//                 text: widget.item.name ?? "No name",
//                 size: 16.sp,
//                 thisfontWeight: FontWeight.w500,
//                 textColor: const Color(0xff2C2C2C),
//               ),
//               SizedBox(height: 4.h),
//               MyText2(
//                 text: "\$${widget.item.price}",
//                 size: 16.sp,
//                 thisfontWeight: FontWeight.w400,
//                 textColor: const Color(0xff2C2C2C),
//               ),
//               SizedBox(height: 6.h),
//               // Quantity row
//               Row(
//                 children: [
//                   // minus
//                   Container(
//                     height: 28.h,
//                     width: 28.w,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xffF5F1EB),
//                     ),
//                     child: const Center(
//                       child: Text("-"),
//                     ),
//                   ),

//                   SizedBox(width: 8.w),

//                   Text(
//                     "${widget.item.quantity}",
//                     style: TextStyle(fontSize: 16.sp),
//                   ),

//                   SizedBox(width: 8.w),

//                   // plus
//                   Container(
//                     height: 28.h,
//                     width: 28.w,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xffF5F1EB),
//                     ),
//                     child: const Center(
//                       child: Text("+"),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const Spacer(),
//           BlocConsumer<RemoveCartCubit, RemoveCartState>(
//             listenWhen: (previous, current) => current is RemoveCartSuccess,
//             listener: (context, state) {
//               if (state is RemoveCartSuccess) {
//                 context.read<CartCubit2>().getCart();

//                 ScaffoldMessenger.of(context)
//                   ..hideCurrentSnackBar()
//                   ..showSnackBar(
//                     SnackBar(
//                       behavior: SnackBarBehavior.floating,
//                       duration: const Duration(seconds: 3),
//                       margin: EdgeInsets.all(20.w),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16.r),
//                       ),
//                       content: Text(state.message),
//                     ),
//                   );
//               }
//             },
//             builder: (context, state) {
//               final cubit = context.read<RemoveCartCubit>();

//               final isLoading =
//                   state is RemoveCartLoading && cubit.currentId == widget.item.id;

//               return IconButton(
//                 onPressed: isLoading
//                     ? null
//                     : () async {
//                         cubit.removeProduct(cartId: widget.item.id);
// //               await context.read<CartCubit2>().getCart();
// // await context.read<CartCubit2>().refreshCart();
//                       },
//                 icon: isLoading
//                     ? SizedBox(
//                         width: 20.w,
//                         height: 20.w,
//                         child: const CircularProgressIndicator(
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : Icon(
//                         Icons.delete_outline,
//                         color: Colors.red,
//                         size: 22.sp,
//                         ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// class SideStaggerItem extends StatefulWidget {
//   final Widget child;
//   final int index;
//   final dynamic itemId; // استقبال الـ ID لمعرفة حالة حذف العنصر الحالي

//   const SideStaggerItem({
//     super.key,
//     required this.child,
//     required this.index,
//     required this.itemId,
//   });

//   @override
//   State<SideStaggerItem> createState() => _SideStaggerItemState();
// }

// class _SideStaggerItemState extends State<SideStaggerItem> {
//   double opacity = 0;
//   double offsetX = 60;

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration(milliseconds: widget.index * 80), () {
//       if (!mounted) return;

//       setState(() {
//         opacity = 1;
//         offsetX = 0;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // الاستماع لحالة الحذف الخاصة بالـ Cubit
//     return BlocListener<RemoveCartCubit, RemoveCartState>(
//       listenWhen: (previous, current) => 
//           current is RemoveCartLoading && context.read<RemoveCartCubit>().currentId == widget.itemId,
//       listener: (context, state) {
//         // عندما يبدأ الحذف، يتم سحب العنصر تدريجياً بنفس الاتجاه المعاكس للخروج (إلى اليمين خارج الشاشة)
//         setState(() {
//           opacity = 0;
//           offsetX = MediaQuery.of(context).size.width; // خروج كامل إلى اليمين
//         });
//       },
//       child: AnimatedOpacity(
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeOut,
//         opacity: opacity,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 400),
//           curve: Curves.easeOut,
//           transform: Matrix4.translationValues(offsetX, 0, 0),
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }













import 'package:ecommere2/data/cubit/addToCart.dart';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/removedCartStatus.dart';
import 'package:ecommere2/data/status/cartStatus..dart';
import 'package:ecommere2/data/status/removedStatus.dart';
import 'package:ecommere2/logic/models/cartitemModel.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart'; 

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartCubit2>().getCart();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit2>().getCart();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF8F5),
        title: MyText(
          text: "Shopping Cart",
          size: 24.sp,
          thisfontWeight: FontWeight.w500,
          textColor: const Color(0xff2C2C2C),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocBuilder<CartCubit2, AllCartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.grey,
              ));
            }

            if (state is CartError) {
              return Center(child: Text(state.message));
            }

            if (state is CartLoaded) {
              final items = state.items;
              final details = state.details;

              if (items.isEmpty) {
                return Center(
                  child: MyText(
                    text: "Your cart is empty\nStart Shopping Now",
                    size: 18.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor: Colors.grey.shade800,
                  ),
                );
              }

              return CustomRefreshIndicator(
                onRefresh: () async {
                  await context.read<CartCubit2>().getCart();
                },
                offsetToArmed: 60.h, 
                builder: (context, child, controller) {
                  return AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          if (!controller.isIdle)
                            Positioned(
                              top: 15.h * controller.value, 
                              child: Opacity(
                                opacity: controller.value.clamp(0.0, 1.0),
                                child: Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child: Transform.rotate(
                                    // 👈 التعديل هنا: استخدام IndicatorState.loading بدلاً من refreshing
                                    angle: controller.status == IndicatorState.loading
                                        ? (controller.value * 10 * 3.14159)
                                        : (controller.value * 4 * 3.14159),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100.r),
                                      child: Image.asset(
                                        "images/logo.png", 
                                        height: 40.w,
                                        width: 40.w,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.refresh, color: const Color(0xff5C6B4A), size: 30.sp);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          
                          Transform.translate(
                            offset: Offset(0, 60.h * controller.value),
                            child: child,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(), 
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      ...List.generate(items.length, (index) {
                        return SideStaggerItem(
                          key: ValueKey(items[index].id),
                          index: index,
                          itemId: items[index].id,
                          child: ProductCart(item: items[index]),
                        );
                      }),

                      SizedBox(height: 24.h),

                      Container(
                        padding: EdgeInsets.all(20.w),
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "Order Summary",
                              size: 18.sp,
                              thisfontWeight: FontWeight.w500,
                              textColor: const Color(0xff2C2C2C),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                MyText2(
                                  text: "Subtotal",
                                  size: 16.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff2C2C2C),
                                ),
                                const Spacer(),
                                MyText2(
                                  text: "\$${details.subTotal}",
                                  size: 16.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff2C2C2C),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.h),
                            Row(
                              children: [
                                MyText2(
                                  text: "Shipping",
                                  size: 16.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff2C2C2C),
                                ),
                                const Spacer(),
                                MyText2(
                                  text: "\$${details.deliveryFee}",
                                  size: 16.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff2C2C2C),
                                ),
                              ],
                            ),
                            SizedBox(height: 9.h),
                            Divider(
                                color: const Color(0xff5C6B4A).withOpacity(.15)),
                            SizedBox(height: 9.h),
                            Row(
                              children: [
                                MyText2(
                                  text: "Total",
                                  size: 16.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff2C2C2C),
                                ),
                                const Spacer(),
                                MyText(
                                  text: "\$${details.totalCost}",
                                  size: 22.sp,
                                  thisfontWeight: FontWeight.w400,
                                  textColor: const Color(0xff2C2C2C),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Mybutton(text: "Proceed to Checkout", s: 20, h: 38),

                      SizedBox(height: 44.h),
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
}

class ProductCart extends StatefulWidget {
  final CartItem item;

  const ProductCart({
    super.key,
    required this.item,
  });

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Image.network(
              widget.item.image ?? "",
              height: 80.h,
              width: 90.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 80.h,
                  width: 90.w,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),

          SizedBox(width: 16.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText2(
                text: widget.item.name ?? "No name",
                size: 16.sp,
                thisfontWeight: FontWeight.w500,
                textColor: const Color(0xff2C2C2C),
              ),
              SizedBox(height: 4.h),
              MyText2(
                text: "\$${widget.item.price}",
                size: 16.sp,
                thisfontWeight: FontWeight.w400,
                textColor: const Color(0xff2C2C2C),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF5F1EB),
                    ),
                    child: const Center(
                      child: Text("-"),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  Text(
                    "${widget.item.quantity}",
                    style: TextStyle(fontSize: 16.sp),
                  ),

                  SizedBox(width: 8.w),

                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF5F1EB),
                    ),
                    child: const Center(
                      child: Text("+"),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),
          BlocConsumer<RemoveCartCubit, RemoveCartState>(
            listenWhen: (previous, current) => current is RemoveCartSuccess,
            listener: (context, state) {
              if (state is RemoveCartSuccess) {
                context.read<CartCubit2>().getCart();

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 3),
                      margin: EdgeInsets.all(20.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      content: Text(state.message),
                    ),
                  );
              }
            },
            builder: (context, state) {
              final cubit = context.read<RemoveCartCubit>();

              final isLoading =
                  state is RemoveCartLoading && cubit.currentId == widget.item.id;

              return IconButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        cubit.removeProduct(cartId: widget.item.id);
                        context.read<CartCubit2>().getCart();
                      },
                icon: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 22.sp,
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SideStaggerItem extends StatefulWidget {
  final Widget child;
  final int index;
  final dynamic itemId;

  const SideStaggerItem({
    super.key,
    required this.child,
    required this.index,
    required this.itemId,
  });

  @override
  State<SideStaggerItem> createState() => _SideStaggerItemState();
}

class _SideStaggerItemState extends State<SideStaggerItem> {
  double opacity = 0;
  double offsetX = 60;

  @override
  void initState() {
    context.read<CartCubit2>().getCart();
    super.initState();

    Future.delayed(Duration(milliseconds: widget.index * 0), () {
      if (!mounted) return;

      setState(() {
        opacity = 1;
        offsetX = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoveCartCubit, RemoveCartState>(
      listenWhen: (previous, current) => 
          current is RemoveCartLoading && context.read<RemoveCartCubit>().currentId == widget.itemId,
      listener: (context, state) {
        setState(() {
          opacity = 0;
          offsetX = MediaQuery.of(context).size.width;
        });
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        opacity: opacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(offsetX, 0, 0),
          child: widget.child,
        ),
      ),
    );
  }
}