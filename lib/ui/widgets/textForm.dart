// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyTextForm extends StatelessWidget {
//   final String hint ; 
//    final bool  suffix ;
//    final double h;
//     TextEditingController? c;
//    MyTextForm({super.key, required this.hint,required this.suffix,  this.h = 40,  this.c });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//                 height: h.h,
//                  child: TextFormField(
//                   controller:c ,
//                   textAlignVertical: TextAlignVertical.top,
//                   expands: true,
//                   maxLines: null,
//                   minLines: null,
//                 style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w400),
//                   decoration: InputDecoration(
//                     suffix: suffix?Icon(Icons.visibility):SizedBox.shrink(),
//                     fillColor: Color(0xffFFFFFF),
//                     filled: true,
                    
//                     hint: MyText2(text: hint,textAlign: TextAlign.start, size: 16.sp,
//                      thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C).withOpacity(.5)),
//                      border:
//                       OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
//                       borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
//                      enabledBorder:
//                       OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
//                       borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
//                      disabledBorder:
//                       OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
//                       borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
//                      focusedBorder:
//                       OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),
//                       borderSide: BorderSide(color: Color(0xff5C6B4A).withOpacity(.15))),
//                   ),
                  
//                  ),
//                );
//   }
// }






import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextForm extends StatefulWidget {
  final String hint;
  final bool suffix;
  final double h;
  final TextEditingController? c;

  const MyTextForm({
    super.key,
    required this.hint,
    required this.suffix,
    this.h = 40,
    this.c,
  });

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  late bool obscure;

  @override
  void initState() {
    super.initState();

    // اذا suffix=true يعتبر Password Field
    obscure = widget.suffix;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.h.h,
      child: TextFormField(
        controller: widget.c,
        obscureText: obscure,

        textAlignVertical: TextAlignVertical.top,


        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        maxLines: widget.suffix ? 1 : null,
        minLines: widget.suffix ? 1 : null,
        expands: widget.suffix ? false : true,
        decoration: InputDecoration(
          suffixIcon: widget.suffix
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xff5C6B4A),
                  ),
                )
              : const SizedBox.shrink(),

          fillColor: const Color(0xffFFFFFF),
          filled: true,

          hint: MyText2(
            text: widget.hint,
            textAlign: TextAlign.start,
            size: 16.sp,
            thisfontWeight: FontWeight.w400,
            textColor: const Color(0xff2C2C2C).withOpacity(.5),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: const Color(0xff5C6B4A).withOpacity(.15),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: const Color(0xff5C6B4A).withOpacity(.15),
            ),
          ),

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: const Color(0xff5C6B4A).withOpacity(.15),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: const Color(0xff5C6B4A).withOpacity(.15),
            ),
          ),
        ),
      ),
    );
  }
}