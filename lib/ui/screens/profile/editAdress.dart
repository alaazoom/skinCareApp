import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';

class EditAddressScreen extends StatefulWidget {
  final int id;
  final String addressType;
  final String city;
  final String block;
  final String buildingNumber;
  final String mobile;

  const EditAddressScreen({
    super.key,
    required this.id,
    required this.addressType,
    required this.city,
    required this.block,
    required this.buildingNumber,
    required this.mobile,
  });

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController cityController;
  late TextEditingController blockController;
  late TextEditingController buildingController;
  late TextEditingController mobileController;

  String? selectedAddressType;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    selectedAddressType = widget.addressType;

    cityController = TextEditingController(text: widget.city);
    blockController = TextEditingController(text: widget.block);
    buildingController = TextEditingController(text: widget.buildingNumber);
    mobileController = TextEditingController(text: widget.mobile);
  }

  Future<void> updateAddress() async {
    if (selectedAddressType == null ||
        cityController.text.isEmpty ||
        blockController.text.isEmpty ||
        buildingController.text.isEmpty ||
        mobileController.text.isEmpty) {
      return;
    }

    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final url = Uri.parse(
        "https://tullana.toldpath.com/api/customer/profile/address/update",
      );

      final body = {
        "id": widget.id,
        "address_type": selectedAddressType,
        "city": cityController.text,
        "block": blockController.text,
        "building_number": buildingController.text,
        "mobile": mobileController.text,
      };

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        Navigator.pop(context, true); // 🔥 refresh trigger
      }
    } catch (e) {
      print(e);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),

      appBar: AppBar(
        title: const Text("Edit Address"),
        backgroundColor: const Color(0xffFAF8F5),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            DropdownButtonFormField<String>(
              value: selectedAddressType,
              items: ["Home", "Work"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => selectedAddressType = v),
            ),

            SizedBox(height: 10.h),

            MyTextForm(hint: "City", c: cityController,suffix: false,),
            MyTextForm(hint: "Block", c: blockController,suffix: false,),
            MyTextForm(hint: "Building Number", c: buildingController,suffix: false,),
            MyTextForm(hint: "Mobile", c: mobileController,suffix: false,),

            const SizedBox(height: 20),

            InkWell(
              onTap: isLoading ? null : updateAddress,
              child: Mybutton(
                text: isLoading ? "Loading..." : "Update Address",
                s: 20,
                h: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}