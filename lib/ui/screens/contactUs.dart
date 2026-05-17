import 'package:ecommere2/logic/gettingData/getSupport.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactusScreen extends StatefulWidget {
   ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  TextEditingController issueTypeController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  void sendIssue(BuildContext context) async {
  final result = await IssueService().sendIssue(
    issueType: issueTypeController.text,
    description: descriptionController.text,
  );

  if (result == null) {
    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Something went wrong",
              style: TextStyle(
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
);
    return;
  }

  if (result["status"] == true) {
    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              result["message"] ?? "Success",
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
);
setState(() {
  
  issueTypeController.text="";
  descriptionController.text="";
});

Future.delayed(Duration(seconds:3),(){Navigator.pop(context);});

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              result["message"] ?? "No Internet Connection",
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
);
    
  }
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF8F5),
        title: MyText(text: "Contact Us", size: 24.sp, thisfontWeight: FontWeight.w600,
         textColor: Color(0xff2C2C2C)),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText2(text: "Have a question or feedback? We'd love to hear from you. Send us a message and we'll respond as soon as possible.",
                 size: 16.sp, thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B),textAlign: TextAlign.start,),
                 SizedBox(height: 24.h,),
                 ContactInfoSection(),
                 SizedBox(height: 24.h,),
                  MyText2(text: "Subject", size: 18.sp, thisfontWeight: FontWeight.w600,
                     textColor: Color(0xff2C2C2C)),
            SizedBox(height: 8.h,),
            MyTextForm(hint: "What is this about?", suffix: false,c: issueTypeController,),
            SizedBox(height: 16.h,),
                  MyText2(text: "Message", size: 18.sp, thisfontWeight: FontWeight.w600,
                     textColor: Color(0xff2C2C2C)),
            SizedBox(height: 8.h,),
            MyTextForm(hint: "Write your message here...", suffix: false,h: 100,c: descriptionController,),
            SizedBox(height: 30.h,),
            InkWell(
              onTap: (){sendIssue(context);},
              child: Mybutton(text: "Send Message",h: 40,s: 20,)),
            SizedBox(height: 30.h,),
            
            
            
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}





























class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        contactCard(
          icon: Icons.email_outlined,
          title: "Email",
          value: "hello@skincare.com",
        ),

        const SizedBox(height: 12),

        contactCard(
          icon: Icons.phone_outlined,
          title: "Phone",
          value: "+1 (555) 123-4567",
        ),

        const SizedBox(height: 12),

        contactCard(
          icon: Icons.location_on_outlined,
          title: "Address",
          value: "123 Beauty Lane,\nNew York, NY 10001",
        ),
      ],
    );
  }

  Widget contactCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding:  EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [

          // icon circle
          Container(
            height: 38.h,
            width: 38.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff5C6B4A).withOpacity(.1),
            ),
            child: Icon(
              icon,
              color: const Color(0xff5C6B4A),
              size: 20.sp,
            ),
          ),

           SizedBox(width: 16.w),

          // text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}