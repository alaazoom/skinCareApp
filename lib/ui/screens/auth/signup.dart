// import 'package:ecommere2/logic/auth/createAccount.dart';
// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:ecommere2/ui/widgets/textForm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffFAF8F5),
//       appBar: AppBar(
//         backgroundColor: Color(0xffFAF8F5),


//       ),
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 24.w ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // SizedBox(height: 31.h,),
//                 MyText(text: "Create Account", size: 36.sp,
//                  thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                  SizedBox(height: 7.h,),
//                  MyText2(text: "Join us today", size: 16.sp,
//                   thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B)),
//                 //  Text("Sign in to continue")
//                 SizedBox(height: 32.h,),
//                 MyText2(text: "Full Name", size: 14.sp,
//                   thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                    SizedBox(height: 8.h,),
//                    MyTextForm(hint: "Your full name",suffix: false,),
//                 SizedBox(height: 16.h,),
//                 MyText2(text: "Email Address", size: 14.sp,
//                   thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                    SizedBox(height: 8.h,),
//                    MyTextForm(hint: "your.email@example.com",suffix: false,),
//                 SizedBox(height: 16.h,),
//                 MyText2(text: "Phone Number", size: 14.sp,
//                   thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                    SizedBox(height: 8.h,),
//                    MyTextForm(hint: "+1 (555) 000-0000",suffix: false,),
//                 SizedBox(height: 16.h,),
//                 MyText2(text: "Password", size: 14.sp,
//                   thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                    SizedBox(height: 8.h,),
//                    MyTextForm(hint: "Enter your password",suffix: true,),
//                 SizedBox(height: 16.h,),
//                 MyText2(text: "Confirm Password", size: 14.sp,
//                   thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                    SizedBox(height: 8.h,),
//                    MyTextForm(hint: "Confirm your password",suffix: true,),
//                    SizedBox(height: 40.h,),
                   
//                    InkWell( 
//                     onTap: (){
//                        AuthService().register(
//       context: context,
//       firstName: firstNameController.text,
//       email: emailController.text,
//       phone: phoneController.text,
//       password: passwordController.text,
//       passwordConfirmation: confirmPasswordController.text,
//     );
//                     },
                    
                    
                    
//                     child: Mybutton(text: "Create Account")),
//                    SizedBox(height: 24.h,),
//                    Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MyText2(text: "Already have an account? ", size: 16.sp, thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B))
//                       ,InkWell(
//                          onTap: () {
//                           Navigator.pop(context);
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
//                     },
//                         child: MyText2(text: " Sign In", size: 16.sp, thisfontWeight: FontWeight.w400, textColor: Color(0xff5C6B4A)))
//                     ],
//                    ),
//                     SizedBox(height: 33.h,),
            
    
                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:ecommere2/data/cubit/allProductCubit.dart';
import 'package:ecommere2/data/cubit/favCubit.dart';
import 'package:ecommere2/data/cubit/favProductsCubot.dart';
import 'package:ecommere2/data/cubit/userCubot.dart';
import 'package:ecommere2/logic/auth/createAccount.dart';
import 'package:ecommere2/logic/cache/userCache.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/favAPI.dart';
import 'package:ecommere2/logic/gettingData/getAllProducts.dart';
import 'package:ecommere2/logic/gettingData/getUser.dart';
import 'package:ecommere2/ui/screens/navigationPage.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  bool isLoading = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void showTopSnackBar(String message, bool isSuccess) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSuccess ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(14),
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
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
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

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF8F5),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                MyText(
                  text: "Create Account",
                  size: 36.sp,
                  thisfontWeight: FontWeight.w500,
                  textColor: Color(0xff2C2C2C),
                ),

                SizedBox(height: 7.h),

                MyText2(
                  text: "Join us today",
                  size: 16.sp,
                  thisfontWeight: FontWeight.w400,
                  textColor: Color(0xff8B8B8B),
                ),

                SizedBox(height: 32.h),

                MyText2(text: "Full Name", size: 14.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor: Color(0xff2C2C2C)),

                SizedBox(height: 8.h),

                MyTextForm(
                  hint: "Your fisrt name",
                  suffix: false,
                  c: firstNameController,
                ),

                SizedBox(height: 16.h),
                MyTextForm(
                  hint: "Your last name",
                  suffix: false,
                  c: lastNameController,
                ),

                SizedBox(height: 16.h),

                MyText2(text: "Email Address", size: 14.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor: Color(0xff2C2C2C)),

                SizedBox(height: 8.h),

                MyTextForm(
                  hint: "your.email@example.com",
                  suffix: false,
                  c: emailController,
                ),

                SizedBox(height: 16.h),

                MyText2(text: "Phone Number", size: 14.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor: Color(0xff2C2C2C)),

                SizedBox(height: 8.h),

                MyTextForm(
                  hint: "+1 (555) 000-0000",
                  suffix: false,
                  c: phoneController,
                ),

                SizedBox(height: 16.h),

                MyText2(text: "Password", size: 14.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor: Color(0xff2C2C2C)),

                SizedBox(height: 8.h),

                MyTextForm(
                  hint: "Enter your password",
                  suffix: true,
                  c: passwordController,
                ),

                SizedBox(height: 16.h),

                MyText2(text: "Confirm Password", size: 14.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor: Color(0xff2C2C2C)),

                SizedBox(height: 8.h),

                MyTextForm(
                  hint: "Confirm your password",
                  suffix: true,
                  c: confirmPasswordController,
                ),

                SizedBox(height: 40.h),
InkWell(
  onTap: isLoading
      ? null
      : () async {
          if (firstNameController.text.isEmpty ||
              emailController.text.isEmpty ||
              phoneController.text.isEmpty ||
              lastNameController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty) {
            showTopSnackBar("Please fill all fields", false);
            return;
          }

          if (passwordController.text != confirmPasswordController.text) {
            showTopSnackBar("Passwords do not match", false);
            return;
          }

          setState(() => isLoading = true);

          try {
             await AuthService().register(
              context: context,
  firstName: firstNameController.text,
  lastName: lastNameController.text,
  email: emailController.text,
  phone: phoneController.text,
  password: passwordController.text,
  passwordConfirmation: confirmPasswordController.text,
);



          } catch (e) {
            showTopSnackBar(e.toString(), false);
          }

          setState(() => isLoading = false);
        },
  child: AbsorbPointer(
    absorbing: isLoading,
    child: Opacity(
      opacity: isLoading ? 0.7 : 1,
      child: isLoading
          ? Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.grey,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              ),
            )
          : Mybutton(text: "Create Account"),
    ),
  ),
),
//                 InkWell(
//                   onTap: isLoading
//                       ? null
//                       : () async {

//                           if (firstNameController.text.isEmpty ||
//                               emailController.text.isEmpty ||
//                               phoneController.text.isEmpty ||
//                               passwordController.text.isEmpty ||
//                               confirmPasswordController.text.isEmpty) {

//                             showTopSnackBar("Please fill all fields", false);
//                             return;
//                           }

//                           if (passwordController.text != confirmPasswordController.text) {
//                             showTopSnackBar("Passwords do not match", false);
//                             return;
//                           }

//                           setState(() => isLoading = true);

//                           await AuthService().register(
//                             context: context,
//                             firstName: firstNameController.text,
//                             email: emailController.text,
//                             phone: phoneController.text,
//                             password: passwordController.text,
//                             passwordConfirmation: confirmPasswordController.text,
//                           );

//                           setState(() => isLoading = false);
                          
//                         },

//                   child: AbsorbPointer(
//   absorbing: isLoading,
//   child: Opacity(
//     opacity: isLoading ? 0.7 : 1,
//     child: Container(
//       child: isLoading
//           ? Center(
//               child: Container(
//                  height: 40.h,width: double.infinity,
//                 decoration: BoxDecoration(
                  
//                   borderRadius: BorderRadius.circular(3333333333333),
//                   color: Colors.grey,
//                 ),
                
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2.5,
//                     color: const Color.fromARGB(255, 255, 255, 255),
//                   ),
//                 ),
//               ),
//             )
//           : Mybutton(text: "Create Account"),
//     ),
//   ),
// ),
//                 ),

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText2(
                      text: "Already have an account? ",
                      size: 16.sp,
                      thisfontWeight: FontWeight.w400,
                      textColor: Color(0xff8B8B8B),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: MyText2(
                        text: " Sign In",
                        size: 16.sp,
                        thisfontWeight: FontWeight.w400,
                        textColor: Color(0xff5C6B4A),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 33.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}