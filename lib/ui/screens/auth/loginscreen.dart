



import 'package:ecommere2/logic/auth/loginAuth.dart';
import 'package:ecommere2/ui/screens/auth/forgotpassword.dart';
import 'package:ecommere2/ui/screens/navigationPage.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommere2/ui/screens/auth/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;

  TextEditingController emailController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  void showTopSnackBar(
      String message,
      bool isSuccess,
      ) {

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
              color: isSuccess
                  ? Colors.green
                  : Colors.red,
              borderRadius:
              BorderRadius.circular(14),
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

    Future.delayed(
      const Duration(seconds: 2),
          () {
        entry.remove();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF8F5),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
          
              SizedBox(height: 36.h),
              Center(child: Image.asset("images/logo.png",width: 100.w,height: 80.h,)),
              SizedBox(height: 8.h),
          
              MyText(
                text: "Welcome Back",
                size: 36.sp,
                thisfontWeight: FontWeight.w500,
                textColor: Color(0xff2C2C2C),
              ),
          
              SizedBox(height: 7.h),
          
              MyText2(
                text: "Sign in to continue",
                size: 16.sp,
                thisfontWeight: FontWeight.w400,
                textColor: Color(0xff8B8B8B),
              ),
          
              SizedBox(height: 28.h),
          
              MyText2(
                text: "Email Address",
                size: 14.sp,
                thisfontWeight: FontWeight.w500,
                textColor: Color(0xff2C2C2C),
              ),
          
              SizedBox(height: 8.h),
          
              MyTextForm(
                hint: "your.email@example.com",
                suffix: false,
                c: emailController,
              ),
          
              SizedBox(height: 20.h),
          
              MyText2(
                text: "Password",
                size: 14.sp,
                thisfontWeight: FontWeight.w500,
                textColor: Color(0xff2C2C2C),
              ),
          
              SizedBox(height: 8.h),
          
              MyTextForm(
                hint: "Enter your password",
                suffix: true,
                c: passwordController,
              ),
          
              SizedBox(height: 20.h),
          
              Row(
                children: [
          
                  Spacer(),
          
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: MyText2(
                      text: "Forgot Password?",
                      size: 14.sp,
                      thisfontWeight:
                      FontWeight.w400,
                      textColor:
                      Color(0xff5C6B4A),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 33.h),
          
              InkWell(
          
                onTap: isLoading
                    ? null
                    : () async {
          
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
          
                    showTopSnackBar(
                      "Please fill all fields",
                      false,
                    );
          
                    return;
                  }
          
                  setState(() {
                    isLoading = true;
                  });
          
                  await LoginService().login(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
          
                  setState(() {
                    isLoading = false;
                  });
          
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         BottomNavScreen(),
                  //   ),
                  // );
                },
          
                child:AbsorbPointer(
            absorbing: isLoading,
            child: Opacity(
              opacity: isLoading ? 0.7 : 1,
              child: Container(
                child: isLoading
            ? Center(
                child: Container(
                   height: 40.h,width: double.infinity,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(3333333333333),
                    color: Colors.grey,
                  ),
                  
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              )
            : Mybutton(text: "Sign In"),
              ),
            ),
          ),
                //  AbsorbPointer(
                //   absorbing: isLoading,
                //   child: Opacity(
                //     opacity: isLoading ? 0.7 : 1,
                //     child: Container(
                //       child: isLoading
                //           ? Container(
                //         height: 56.h,
                //         decoration: BoxDecoration(
                //           color: Color(0xff5C6B4A),
                //           borderRadius:
                //           BorderRadius.circular(16),
                //         ),
                //         child: Center(
                //           child: SizedBox(
                //             height: 24.h,
                //             width: 24.w,
                //             child:
                //             CircularProgressIndicator(
                //               strokeWidth: 2.5,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //       )
                //           : Mybutton(
                //         text: "Sign In",
                //       ),
                //     ),
                //   ),
                // ),
              ),
          
              SizedBox(height: 24.h),
          
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
          
                  MyText2(
                    text:
                    "Don't have an account? ",
                    size: 16.sp,
                    thisfontWeight:
                    FontWeight.w400,
                    textColor:
                    Color(0xff8B8B8B),
                  ),
          
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         SignUpScreen(),
                      //   ),
                      // );


                      Navigator.push(
  context,
  PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 900),
    pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // من اليمين
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ),
);
                    },
                    child: MyText2(
                      text: " Sign Up",
                      size: 16.sp,
                      thisfontWeight:
                      FontWeight.w400,
                      textColor:
                      Color(0xff5C6B4A),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}