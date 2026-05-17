import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpCodeFields extends StatefulWidget {
  final TextEditingController controller;

  const OtpCodeFields({
    super.key,
    required this.controller,
  });

  @override
  State<OtpCodeFields> createState() => _OtpCodeFieldsState();
}

class _OtpCodeFieldsState extends State<OtpCodeFields> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  void _onChanged() {
    widget.controller.text =
        controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 60.w,
          height: 60.w,

          child: TextField(
            controller: controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,

            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),

            onChanged: (value) {
              _onChanged();

              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        );
      }),
    );
  }
}