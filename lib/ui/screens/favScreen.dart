

// import 'package:ecommere2/data/cubit/addToCart.dart';
// import 'package:ecommere2/data/cubit/cartCubit.dart';
// import 'package:ecommere2/data/cubit/favCubit.dart';
// import 'package:ecommere2/data/cubit/favProductsCubot.dart';
// import 'package:ecommere2/data/status/addToCartStatus.dart';
// import 'package:ecommere2/logic/models/favModel.dart';
// import 'package:ecommere2/shimmer/favShimmer.dart';
// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class FavouriteScreen extends StatelessWidget {
//   const FavouriteScreen({super.key});

//   @override  
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavListCubit, FavListState>(
//       builder: (context, state) {
//         final favListCubit = context.watch<FavListCubit>();

//         return Scaffold(
//           backgroundColor: const Color(0xffFAF8F5),

//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: const Color(0xffFAF8F5),
//             title: MyText(
//               text: "Favorites",
//               size: 24.sp,
//               thisfontWeight: FontWeight.w500,
//               textColor: const Color(0xff2C2C2C),
//             ),
//           ),

//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),

//             child: state is FavListLoading
//                 ? const FavShimmer()
//                 : favListCubit.favorites.isEmpty
//                     ? Center(
//                         child: MyText(
//                           text: "No favorites yet",
//                           size: 18.sp,
//                           thisfontWeight: FontWeight.w500,
//                           textColor: Colors.grey,
//                         ),
//                       )
//                     : MasonryGridView.count(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 16.h,
//                         crossAxisSpacing: 16.w,
//                         itemCount: favListCubit.favorites.length,
//                         padding: EdgeInsets.only(bottom: 20.h),

//                         itemBuilder: (context, index) {
//   final item = favListCubit.favorites[index];

//   return StaggerItem(
//     index: index,
//     child: FavCard(item: item),
//   );
// },
//                       ),
//           ),
//         );
//       },
//     );
//   }
// }






import 'package:ecommere2/data/cubit/addToCart.dart';
import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/cubit/favProductsCubot.dart';
import 'package:ecommere2/data/status/addToCartStatus.dart';
import 'package:ecommere2/logic/models/favModel.dart';
import 'package:ecommere2/shimmer/favShimmer.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavListCubit, FavListState>(
      builder: (context, state) {
        final favListCubit = context.watch<FavListCubit>();

        return Scaffold(
          backgroundColor: const Color(0xffFAF8F5),

          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xffFAF8F5),
            title: MyText(
              text: "Favorites",
              size: 24.sp,
              thisfontWeight: FontWeight.w500,
              textColor: const Color(0xff2C2C2C),
            ),
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),

            child: state is FavListLoading
                ? const FavShimmer()
                : favListCubit.favorites.isEmpty
                    ? Center(
                        child: MyText(
                          text: "No favorites yet",
                          size: 18.sp,
                          thisfontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                      )

                    : MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                        itemCount: favListCubit.favorites.length,

                        itemBuilder: (context, index) {
                          final item = favListCubit.favorites[index];

                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) {
                              return FadeTransition(
                                opacity: anim,
                                child: SizeTransition(
                                  sizeFactor: anim,
                                  child: child,
                                ),
                              );
                            },

                            child: FavCard(
                              key: ValueKey(item.id),
                              item: item,
                            ),
                          );
                        },
                      ),
          ),
        );
      },
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
  double offset = 20;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: widget.index * 90), () {
      if (!mounted) return;

      setState(() {
        opacity = 1;
        offset = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      opacity: opacity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, offset, 0),
        child: widget.child,
      ),
    );
  }
}

class FavCard extends StatefulWidget {
  final FavoriteModel item;
  
  const FavCard({
    super.key,
    required this.item,
  });

  @override
  State<FavCard> createState() => _FavCardState();
}

class _FavCardState extends State<FavCard> {
  bool isVisible = true;
  void removeItem(VoidCallback onRemoved) {
  setState(() {
    isVisible = false;
  });
    Future.delayed(const Duration(milliseconds: 250), () {
    onRemoved();

    if (mounted) {
      setState(() {}); // مهم يجبر إعادة بناء
    }
  });


}
void _showTopSnack(BuildContext context, String message, Color color) {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: 60,
      left: 16,
      right: 16,

      child: Material(
        color: Colors.transparent,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),

          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
              )
            ],
          ),

          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
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

  @override
  Widget build(BuildContext context) {

    /// 👇 يسمع مباشرة لأي تغيير
    final favCubit = context.watch<FavCubit>();

    final favListCubit =
        context.read<FavListCubit>();

    final isFav = favCubit.isFav(widget.item.id);

    return AnimatedOpacity(
  duration: const Duration(milliseconds: 300),
  opacity: isVisible ? 1 : 0,
  child: AnimatedSlide(
    duration: const Duration(milliseconds: 300),
    offset: isVisible ? Offset.zero : const Offset(0.5, 0),
    child: IgnorePointer(
      ignoring: !isVisible,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

          /// IMAGE
          Stack(
            children: [

              ClipRRect(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(24.r),
    topRight: Radius.circular(24.r),
  ),
  child: Image.network(
    widget.item.thumbnail,
    width: double.infinity,
    fit: BoxFit.cover,

    errorBuilder: (context, error, stackTrace) {
      return Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.cover,
      );
    },

    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;

      return Container(
        height: 180.h,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.grey,),
      );
    },
  ),
),

              /// FAVORITE BUTTON
       Positioned(
  top: 10.h,
  right: 10.w,
  child: GestureDetector(
    onTap: () async {
      await favCubit.toggleFav(widget.item.id);

      removeItem(() {
 

      favListCubit.favorites = List.from(favListCubit.favorites)
  ..removeWhere((e) => e.id == widget.item.id);

favListCubit.emit(
  FavListLoaded(favListCubit.favorites),
);
      });
    },
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        key: ValueKey(isFav),
        color: isFav ? Colors.red : Colors.grey,
        size: 30.sp,
      ),
    ),
  ),
),
            ],
          ),

          /// CONTENT
          Padding(
            padding: EdgeInsets.all(10.w),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                MyText(
                  text: widget.item.name,
                  size: 15.sp,
                  thisfontWeight: FontWeight.w700,
                  textColor:
                      const Color(0xff2C2C2C),
                ),

                SizedBox(height: 6.h),

                MyText(
                  text: "\$${widget.item.price}",
                  size: 22.sp,
                  thisfontWeight: FontWeight.bold,
                  textColor:
                      const Color(0xff2C2C2C),
                ),

                SizedBox(height: 14.h),
BlocConsumer<CartCubit, CartState>(
  listenWhen: (previous, current) {
    // يمنع تكرار نفس الحدث مرتين
    return current is CartSuccess || current is CartError;
  },

  listener: (context, state) async {
    if (state is CartSuccess) {
      await context.read<CartCubit2>().getCart();

      _showTopSnack(context, state.message, Colors.green);
    }

    if (state is CartError) {
      final msg = state.message.toLowerCase();

      _showTopSnack(
        context,
        state.message,
        msg.contains("already") ? Colors.green : Colors.red,
      );
    }
  },

  builder: (context, state) {
    final isLoading = state is CartLoadingItem &&
        state.productId == widget.item.id;

    return InkWell(
      onTap: isLoading
          ? null
          : () async{
              context.read<CartCubit>().addToCart(
                    productId: widget.item.id,
                    quantity: 1,
                  );
 await context.read<CartCubit2>().getCart();
                  
            },

      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff5C6B4A),
          borderRadius: BorderRadius.circular(9999),
        ),

        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/Icon.png", height: 24, width: 24),
                    SizedBox(width: 8.w),
                    MyText2(
                      text: "Add to Cart",
                      size: 15.sp,
                      thisfontWeight: FontWeight.w400,
                      textColor: Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  },
),

                // Mybutton(
                //   text: "Add to Cart",
                //   h: 30,
                //   s: 15,
                // ),
              ],
            ),
          ),
        ],
      ),
    ))));
    // ظظظظظظظظظظظظظظظظظظظظظظظظظظ
  }
}










