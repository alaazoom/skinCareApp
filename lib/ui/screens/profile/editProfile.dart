import 'package:ecommere2/data/cubit/updateProfileCubit.dart';
import 'package:ecommere2/data/cubit/userCubot.dart';
import 'package:ecommere2/data/status/updateProfileStatus.dart';
import 'package:ecommere2/data/status/userStatus.dart';
import 'package:ecommere2/logic/models/userModel.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditProfileScreen extends StatefulWidget {
  final String token;

  const EditProfileScreen({super.key, required this.token});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  bool isFilled = false;



  void fillFields(UserModel user) {

  if(isFilled) return;

  firstNameCtrl.text=user.firstName;
  lastNameCtrl.text=user.lastName;
  emailCtrl.text=user.email;
  usernameCtrl.text=user.username;
  phoneCtrl.text=user.phone;
  genderCtrl.text=user.gender ?? "";

  isFilled=true;
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit,UpdateProfileState>(
      listener: (context,state) async{

if (state is UpdateProfileSuccess) {

  await context.read<UserCubit>()
      .fetchUser(widget.token);

  if (!mounted) return;
      ScaffoldMessenger.of(context)
      .showSnackBar(

        SnackBar(

          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          content: Row(
            children: [

              const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),

              SizedBox(width:10.w),

              Expanded(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            ],
          ),

        ),
      );
        Navigator.pop(context);
    }

    if(state is UpdateProfileError){

      ScaffoldMessenger.of(context)
      .showSnackBar(

        SnackBar(

          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          content: Text(
            state.message,
          ),

        ),
      );

    }

  },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          title:  MyText(text: "Edit Profile", 
          size: 24.sp, thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
          backgroundColor: const Color(0xFFF8F8F8),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
      
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
      
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
      
            if (state is UserError) {
              return Center(child: Text(state.message));
            }
      
            if (state is UserLoaded) {
              final user = state.user;
      
              // fill once
              fillFields(user);
      
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
      
                  CircleAvatar(
                    backgroundColor: Color(0xff5C6B4A).withOpacity(.1),
        radius: 55,
        backgroundImage: NetworkImage(user.image),
        child: ClipOval(
      child: Image.network(
        user.image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("images/logo.png");
        },
      ),
        ),
      ),
      
                    const SizedBox(height: 30),
      Row(
                      children: [
                        Expanded(
                          child: MyTextForm(
                            hint: "First Name",
                            suffix: false,
                            c: firstNameCtrl,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: MyTextForm(
                            hint: "Last Name",
                            suffix: false,
                            c: lastNameCtrl,
                          ),
                        ),
                      ],
                    ),                  SizedBox(height: 8.h,),
                    MyTextForm(hint: "Email", suffix: false,c:emailCtrl ,),
                      SizedBox(height: 8.h,),
                    MyTextForm(hint: "Username", suffix: false,c:usernameCtrl ,),
                      SizedBox(height: 8.h,),
                    MyTextForm(hint: "Phone", suffix: false,c:phoneCtrl ,),
      
        
      
                    SizedBox(height: 30),
                    
                                BlocBuilder<UpdateProfileCubit,
              UpdateProfileState>(
              builder:(context,state){

                    return InkWell(
                      onTap:(){

                    context.read<UpdateProfileCubit>()
                    .update(

                    token: widget.token,

                    firstName: firstNameCtrl.text,

                    lastName: lastNameCtrl.text,

                    email: emailCtrl.text,

                    countryCode: "+970",

                    mobile: phoneCtrl.text,

                    );

                    },
                      child: Mybutton(
                      
                      text: state is UpdateProfileLoading
                      ? "Saving..."
                      : "Save Changes",
                      
                      h:37,
                      s:20,
                      
                      
                      
                      ),
                    );

})
                  ],
                ),
              );
            }
      
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}