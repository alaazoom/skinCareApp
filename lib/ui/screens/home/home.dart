import 'package:ecommere2/data/cubit/cartCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/cubit/favProductsCubot.dart';
import 'package:ecommere2/data/status/cartStatus..dart';
import 'package:ecommere2/ui/screens/home/categoryScreen.dart';
import 'package:ecommere2/ui/screens/home/searchscreen.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {

  final VoidCallback onMenuTap;
  const HomeScreen({super.key, required this.onMenuTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final GlobalKey cartKey = GlobalKey();

  // final cartKey = GlobalKey<CartIconKey>();
@override
void initState()  {
  super.initState();
  context.read<CartCubit2>().getCart();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<CartCubit2>().getCart();
  });

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final favCubit = context.read<FavCubit>();
    final listCubit = context.read<FavListCubit>();

    BlocProvider.value(value: context.read<FavCubit>()) ;
  });
}
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xffFAF8F5),
body: SafeArea(
  // top: false,
  
  child: Padding(
    padding:  EdgeInsets.symmetric(horizontal: 24.w),
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8.h,),
          Row(children: [
            MyText(text: "Shop the best\nSkin Products", size: 30.sp, thisfontWeight: FontWeight.w500,
             textColor: Color(0xff2C2C2C)),
             Spacer(),
            Stack(
                      key: cartKey,

              children: [
                Container(height: 30.h,width: 29.w),
                Image.asset("images/bag.png",height: 27.h,width: 27.w),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height:18.h,
                    width:18.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff5C6B4A),
                    ),
                   child: 
                   BlocBuilder<CartCubit2, AllCartState>(
              builder: (context, state) {
                int count = 0;
            
                if (state is CartLoaded) {
                  count = state.items.length;
                }
            
                return Center(
                  child: MyText2(
                    text: "$count",
                    size: 12.sp,
                    thisfontWeight: FontWeight.w600,
                    textColor: Colors.white,
                  ),
                );
              },
            )
                   ,
                  ),
                ),
              ],
            ),
             SizedBox(width: 5.w,),
           IconButton(
  onPressed: widget.onMenuTap,
  icon: Icon(
    Icons.menu,
    size: 26.sp,
    color: Color(0xff5C6B4A),
  ),
)
            
          ],)
         ,   SizedBox(height: 24,),
             Container(
              width:double.infinity,
                  height: 40.h,
                   child: TextFormField(
                     readOnly: true,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(),
      ),
    );
  },
                    
                    expands: true,
                    maxLines: null,
                    minLines: null,
                  style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                     
                      fillColor: Color(0xffFFFFFF),
                      filled: true,
                      prefixIcon: Icon(Icons.search,size: 18.sp,color: Color(0xff8B8B8B),),
                      
                      hint: MyText2(text: "Search products...",textAlign: TextAlign.start, size: 16.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C).withOpacity(.5)),
                       border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
                       enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
                       disabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
                       focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
                    ),
                    
                   ),
                 ),
                 SizedBox(height: 10.h,),
                 HomeSlider(),
                 SizedBox(height: 10.h,),
                CategoryScreen(cartKey: cartKey),
                   SizedBox(height: 31.h,),
       
       
       
       
       
       
       
       
        ],
      ),
    ),
  )),



    );
  }
}




















class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final PageController _controller = PageController();

  int currentIndex = 0;

  final List<Map<String, String>> banners = [
    {
      "title": "New Arrivals",
      "subtitle": "Fresh formulas for radiant skin",
      "image": "images/p3.png",
    },
    {
      "title": "Summer Collection",
      "subtitle": "Light & refreshing skincare",
      "image": "images/p2.png",
    },
    {
      "title": "Best Products",
      "subtitle": "Customer favorites",
      "image":"images/p1.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = banners[index];

              return Container(
                margin:  EdgeInsets.symmetric(horizontal:3.w),
                padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xffEDE2D2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyText(text: item["title"]!, size: 26.sp,
                             thisfontWeight: FontWeight.w500, textColor: Color(0XFF2C2C2C)),
                                          
                             SizedBox(height: 8.h),
                             MyText2(text: item["subtitle"]!,
                              size: 12.sp, thisfontWeight: FontWeight.w400,
                               textColor: Color(0xff2C2C2C).withOpacity(.8)),
                                            
                             SizedBox(height: 16.h),
                             Container(
                              height: 30.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3333),
                                color: Color(0xff5C6B4A)
                              ),
                              child: Center(
                                child: MyText2(text: "Shop Now", size: 16.sp,
                                 thisfontWeight: FontWeight.w500, textColor: Color(0xffFFFFFF)),
                              ),
                             )
                        
                            
                          ],
                        ),
                    
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.cover,
                             width: 100.w,
                          height: 80.h,
                          ),
                        ),
                      ],
                    ),
                 
                  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentIndex == index ? 20.w : 8.w,
              height: 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? Color(0xff5C6B4A)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(2000.r),
              ),
            ),
          ),
        )
                  ],
                ),
              )
              ;
            },
          ),
        ),

        const SizedBox(height: 12),


       
      ],
    );
  }
}
