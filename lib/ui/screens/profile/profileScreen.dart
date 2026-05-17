import 'package:ecommere2/data/cubit/addressCubit.dart';
import 'package:ecommere2/data/cubit/updateProfileCubit.dart';
import 'package:ecommere2/data/cubit/userCubot.dart';
import 'package:ecommere2/data/status/userStatus.dart';
import 'package:ecommere2/logic/cache/userCache.dart';
import 'package:ecommere2/logic/gettingData/getUser.dart';
import 'package:ecommere2/logic/gettingData/updateProfile.dart';
import 'package:ecommere2/ui/screens/profile/allAddresses.dart';
import 'package:ecommere2/ui/screens/profile/editProfile.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF8F5),
        title: MyText(text: "Profile", size: 24.sp, 
        thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              Container(
                padding: EdgeInsets.all(24.w),
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Image.asset("images/logo.png",height: 80.h,width: 80.w,fit: BoxFit.contain,),
                      SizedBox(width: 16.w,),
                     BlocBuilder<UserCubit, UserState>(
  builder: (context, state) {

    if (state is UserLoading) {
      return const SizedBox();
    }

    if (state is UserLoaded) {
      final user = state.user;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          MyText(
            text: user.name, // أو user.firstName + lastName
            size: 22.sp,
            thisfontWeight: FontWeight.w600,
            textColor: const Color(0xff2C2C2C),
          ),

          SizedBox(height: 3.h),

          MyText(
            text: user.email,
            size: 18.sp,
            thisfontWeight: FontWeight.w500,
            textColor: const Color(0xff8B8B8B),
          ),
        ],
      );
    }

    return const SizedBox();
  },
)
                    
                    ],),
                  InkWell(
                     onTap: ()  async{
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

if (token == null) return;
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => MultiBlocProvider(
      providers: [

        BlocProvider.value(
          value: context.read<UserCubit>(),
        ),

        BlocProvider(
          create: (_) => UpdateProfileCubit(
            UpdateProfileApi(),
          ),
        ),

      ],
      child: EditProfileScreen(
        token: token,
      ),
    ),
  ),
);
},
                    child: Container(
                    height: 30.h,width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF5F1EB),
                      borderRadius: BorderRadius.circular(3333333333333),
                    ),
                    child: Center(
                      child: MyText2(text: "Edit Profile", size: 16.sp, 
                      thisfontWeight: FontWeight.w400,
                       textColor: Color(0xff2C2C2C)),
                    ),
                                     ),
                  ),
                 
                  ],
                ),
                
              ),
              SizedBox(height: 12.h,),
              Container(
                width: double.infinity,
                // height: 300.h,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(16.w),
                  child: Column(children: [
                    InkWell(
                      onTap: ()  async{
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

if (token == null) return;
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => MultiBlocProvider(
      providers: [

        BlocProvider.value(
          value: context.read<UserCubit>(),
        ),

        BlocProvider(
          create: (_) => UpdateProfileCubit(
            UpdateProfileApi(),
          ),
        ),

      ],
      child: EditProfileScreen(
        token: token,
      ),
    ),
  ),
);
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => MultiBlocProvider(
//       providers: [

//         BlocProvider(
//           create: (context) => UserCubit(
//             api: UserApi(
//               "https://tullana.toldpath.com/api",
//             ),
//             local: UserLocalStorage(),
//           )..fetchUser(token),
//         ),

//         BlocProvider(
//           create: (_) => UpdateProfileCubit(
//             UpdateProfileApi(),
//           ),
//         ),

//       ],

//       child: EditProfileScreen(
//         token: token,
//       ),
//     ),
//   ),
// );
  
},
                      child: Row(children: [
                        Icon(Icons.person,color: Color(0xff8B8B8B),size: 20.sp,),
                        SizedBox(width: 12.w,),
                        MyText2(text: "Edit Profile", size: 16.sp,
                         thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                         Spacer(),
                         Icon(Icons.arrow_forward_ios,size: 20.sp,color: Color(0xff8B8B8B),),
                        
                      ],),
                    ),
                    SizedBox(height: 10.h,),
                        Divider(color: Color(0xff8B8B8B).withOpacity(.5)),
                       SizedBox(height: 10.h,),
              
              
              
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
                      child: Row(children: [
                        Icon(Icons.location_on,color: Color(0xff8B8B8B),size: 20.sp,),
                        SizedBox(width: 12.w,),
                        MyText2(text: "My Addresses", size: 16.sp,
                         thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                         Spacer(),
                         Icon(Icons.arrow_forward_ios,size: 20.sp,color: Color(0xff8B8B8B),),
                        
                      ],),
                    ),
                    SizedBox(height: 10.h,),
                       Divider(color: Color(0xff8B8B8B).withOpacity(.5)),
                       SizedBox(height: 10.h,),
              
              
              
                    Row(children: [
                      Icon(Icons.history,color: Color(0xff8B8B8B),size: 20.sp,),
                      SizedBox(width: 12.w,),
                      MyText2(text: "Order History", size: 16.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                       Spacer(),
                       Icon(Icons.arrow_forward_ios,size: 20.sp,color: Color(0xff8B8B8B),),
                      
                    ],),
                    SizedBox(height: 10.h,),
                       Divider(color: Color(0xff8B8B8B).withOpacity(.5)),
                       SizedBox(height: 10.h,),
                  
                            
                    Row(children: [
                      Icon(Icons.notifications,color: Color(0xff8B8B8B),size: 20.sp,),
                      SizedBox(width: 12.w,),
                      MyText2(text: "Notifications", size: 16.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                       Spacer(),
                       Icon(Icons.arrow_forward_ios,size: 20.sp,color: Color(0xff8B8B8B),),
                      
                    ],),
                    SizedBox(height: 10.h,),
                        Divider(color: Color(0xff8B8B8B).withOpacity(.5)),
                       SizedBox(height: 10.h,),
                  
                           
                    Row(children: [
                      Icon(Icons.privacy_tip,color: Color(0xff8B8B8B),size: 20.sp,),
                      SizedBox(width: 12.w,),
                      MyText2(text: "Privacy & Security", size: 16.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                       Spacer(),
                       Icon(Icons.arrow_forward_ios,size: 20.sp,color: Color(0xff8B8B8B),),
                      
                    ],),
                    SizedBox(height: 10.h,),
                   Divider(color: Color(0xff8B8B8B).withOpacity(.5)),
                       SizedBox(height: 10.h,),
                  
                           
                    Row(children: [
                      Icon(Icons.help,color: Color(0xff8B8B8B),size: 20.sp,),
                      SizedBox(width: 12.w,),
                      MyText2(text: "Help & Support", size: 16.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                       Spacer(),
                       Icon(Icons.arrow_forward_ios,size: 20.sp,color: Color(0xff8B8B8B),),
                      
                    ],),
                    // SizedBox(height: 10.h,),
                    //    Divider(color: Color(0xff8B8B8B)),
                    //    SizedBox(height: 10.h,),
                  
              
              
                  ],),
                ),
              ),
              SizedBox(height: 24.h,),
              Container(
                height: 40.h,
                width: 
                double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffC44536).withOpacity(.1),
                  borderRadius: BorderRadius.circular(33333),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,color: Color(0xffC44536),size: 20.sp,),
                    SizedBox(width: 8.w,),
                    MyText2(text: "Log Out", size: 16.sp, thisfontWeight: FontWeight.w500,
                     textColor: Color(0xffC44536))
                  ],
                ),
              ),
              SizedBox(height: 33.h,),
            ],
          ),
        ),
      ),
    );
  }
}