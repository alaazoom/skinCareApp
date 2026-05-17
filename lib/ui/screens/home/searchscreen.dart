import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF8F5),
        title: MyText(text: "Search & Filter", size: 24.sp, 
        thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.sp,),
            Container(
                width:double.infinity,
                    height: 40.h,
                     child: TextFormField(
                      autofocus: true,
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
                   SizedBox(height: 20.h,),
                   MyText2(text: "RECENT SEARCHES", 
                   size: 14.sp, thisfontWeight: FontWeight.w500, textColor: Color(0xff8B8B8B)),
                   SizedBox(height: 8.h,),
                   KeywordsWidget(),
                  
          ],
        ),
      ),
      
    );
  }
}











class KeywordsWidget extends StatelessWidget {
  final List<String> keywords = [
    "Vitamin C Serum",
    "Night Cream",
    "Face Oil",
    "Hydrating Mask",
   
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5.w,
        runSpacing: 5.h, 
        children: keywords.map((word) => _buildKeywordItem(word)).toList(),
      ),
    );
  }

  Widget _buildKeywordItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: 
         Color(0xffF5F1EB),
        // const Color(0xffF5F1EB),
        borderRadius: BorderRadius.circular(5000), 
      ),
      child: Text(
        text,
        style:  TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}