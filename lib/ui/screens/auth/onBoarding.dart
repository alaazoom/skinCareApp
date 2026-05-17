



import 'package:ecommere2/ui/screens/auth/loginscreen.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();

  int currentIndex = 0;

  List<Map<String, String>> boardingData = [
    {
      "title": "Welcome to Your\nSkincare Journey",
      "desc":
          "Discover products crafted with care,\ndesigned to bring out your natural beauty",
          "image": "images/b1.png",
    },
    {
      "title": "Nature Meets Science",
      "desc":
          "Experience the perfect blend of natural\ningredients and proven skincare innovation",
          "image": "images/b2.png",
    },
    {
      "title": "Begin Your Glow",
      "desc":
          "Start your personalized skincare routine\nand feel confident in your skin",
          "image": "images/b3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:  EdgeInsets.only(right: 20.w, top: 10.h),
                child: InkWell(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false, 
  );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: boardingData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      key: ValueKey(index),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h,),

                          /// Circle Animation
                          TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 2000),
                            tween: Tween<double>(begin: 0.1, end: 1),
                            curve: Curves.easeOutBack,
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: child,
                              );
                            },
                            child:
                           ClipRRect(
  borderRadius: BorderRadius.circular(1000),
  child: Image.asset(
    boardingData[index]["image"]!,
    height: 150.h,
    width: 220.w,
    fit: BoxFit.cover,
  ),
),
                            //  Container(
                            //   height: 220,
                            //   width: 220,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     color: const Color(0xff7A8467),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.05),
                            //         blurRadius: 20,
                            //         offset: const Offset(0, 10),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),

                          const SizedBox(height: 50),

                          TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 2000),
                            tween: Tween<double>(begin: 40, end: 0),
                            curve: Curves.easeOut,
                            builder: (context, double value, child) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: Opacity(
                                  opacity: 1 - (value / 40),
                                  child: child,
                                ),
                              );
                            },
                            child: MyText(text: boardingData[index]["title"]!,
                             size: 32.sp, thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C))
                          ),

                          const SizedBox(height: 20),

                          /// Description Animation
                          TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 900),
                            tween: Tween<double>(begin: 50, end: 0),
                            curve: Curves.easeOut,
                            builder: (context, double value, child) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: Opacity(
                                  opacity: 1 - (value / 50),
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: MyText2(text: boardingData[index]["desc"]!,
                               size: 14.sp, thisfontWeight: FontWeight.w400,
                                textColor: Color(0xff000000).withOpacity(.5))
                            ),
                          ),

                          const SizedBox(height: 40),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              boardingData.length,
                              (dotIndex) {
                                return AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 300),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  height: 6,
                                  width:
                                      currentIndex == dotIndex ? 22.w : 6.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    color: currentIndex == dotIndex
                                        ? const Color(0xff7A8467)
                                        : Colors.grey.shade300,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,

              ),
              child: GestureDetector(
                onTap: () {
                  if (currentIndex < boardingData.length - 1) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                    );
                  }
                  else{
                   
                    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false, 
  );
                  
                  }
                },
                child: Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xff7A8467),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      currentIndex == boardingData.length - 1
                          ? "Get Started"
                          : "Continue",
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h,)
          ],
        ),
      ),
    );
  }
}