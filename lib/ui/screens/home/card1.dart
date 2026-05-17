import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/status/favStatus.dart';
import 'package:ecommere2/logic/models/productModel.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatefulWidget {
  final String image ;
  final String name ;
  final String price ;
    final  ProductModel  product;

  const ProductCard({super.key, required this.image, required this.name, required this.price,required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    context.read<FavCubit>();
    // TODO: implement initState
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    return   Container(
                height: 187.h,
                width: 166.w,
                // clipBehavior: Clip.none,
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: widget.product.id,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.image,
          
              height: 100.h,
              width: 166.w,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
          
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
          height: 100.h,
          width: 166.w,
          color: Colors.white,
                ),
              ),
          
              errorWidget: (context, url, error) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
          height: 100.h,
          width: 166.w,
          color: Colors.white,
                ),
              ),
            ),
          ),
        )
    // ClipRRect(
    //   borderRadius: BorderRadius.only(
    //     topLeft: Radius.circular(24.r),
    //     topRight: Radius.circular(24.r),
    //   ),
    //   child: Image.network(
    //     image,
    //     height: 100.h,
    //     width: 166.w,
    //     fit: BoxFit.fill,
    //     alignment: Alignment.topCenter,
    //   ),
    // ),
    
       
    
     ,Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Hero(
        tag: "name${widget.product.id}",
        child: MyText2(
          text: widget.name,
          size: 16.sp,
          thisfontWeight: FontWeight.w600,
          textColor: Color(0xff2C2C2C),
          textAlign: TextAlign.start,
        
        ),
      ),
    ),
BlocConsumer<FavCubit, FavState>(
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
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 28.w),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:  EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(.1),
                  blurRadius: 3,
                  spreadRadius:-4,
                  offset: Offset(0, 3),
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
    ),
  );

  overlay.insert(entry);

  Future.delayed(const Duration(seconds: 2), () {
    entry.remove();
  });
}

   if (state is FavSuccess) {
  showTopSnackBar(context, state.message, Colors.grey.shade500);
}

if (state is FavError) {
  showTopSnackBar(context, state.message, Colors.red);
}
  },

  builder: (context, state) {
    final cubit = context.watch<FavCubit>();

    return IconButton(
      onPressed: () {
        cubit.toggleFav(widget.product.id);
      },
      icon: Icon(
        cubit.isFav(widget.product.id)
            ? Icons.favorite
            : Icons.favorite_outline,
        color: cubit.isFav(widget.product.id)
            ? Colors.red
            : Colors.grey,
      ),
    );
  },
)
  ],
),
          SizedBox(height: 5.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           MyText2(text: "★", size: 18.sp,
            thisfontWeight: FontWeight.w500, textColor: Color(0xffC9B896)),
            SizedBox(width: 3.w,),
            MyText2(text: "4.8 (124)", size: 13.sp, thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B))
          ],)
       
       ,SizedBox(height: 8.h,),
       Hero(
        tag: "price${widget.product.id}",
         child: MyText2(text: widget.price, size: 18.sp, thisfontWeight: FontWeight.w400,
          textColor: Color(0xff2C2C2C)),
       )
        ],
      ),
    ),
      ],
    ),
              );
  }
}