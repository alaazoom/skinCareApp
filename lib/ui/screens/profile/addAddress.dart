// import 'dart:convert';

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/textForm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class AddAddressScreen extends StatefulWidget {
//   const AddAddressScreen({super.key});

//   @override
//   State<AddAddressScreen> createState() => _AddAddressScreenState();
// }

// class _AddAddressScreenState extends State<AddAddressScreen> {
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController blockController = TextEditingController();
//   final TextEditingController buildingNumberController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();

//   String? selectedAddressType;

//   @override
//   void dispose() {
//     cityController.dispose();
//     blockController.dispose();
//     buildingNumberController.dispose();
//     mobileController.dispose();
//     super.dispose();
//   }

//   Future<void> saveAddress() async {
//     print("🚀 Start saveAddress");

//     if (
//       selectedAddressType == null ||
//       cityController.text.isEmpty ||
//       blockController.text.isEmpty ||
//       buildingNumberController.text.isEmpty ||
//       mobileController.text.isEmpty
//     ) {
//       print("⚠️ Validation failed");

//       showTopSnack("Please fill all fields", Colors.orange);
//       return;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString("token");

//     print("🔑 Token: $token");

//     final url = Uri.parse(
//       "https://tullana.toldpath.com/api/customer/profile/address/add",
//     );

//     final body = {
//       "address_type": selectedAddressType,
//       "city": cityController.text,
//       "block": blockController.text,
//       "building_number": buildingNumberController.text,
//       "mobile": mobileController.text,
//     };

//     print("📦 Request Body: $body");

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//         body: jsonEncode(body),
//       );

//       print("📡 Status Code: ${response.statusCode}");
//       print("📡 Response Body: ${response.body}");

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 && data["status"] == true) {
//         print("✅ Success");

//         showTopSnack(data["message"] ?? "Success", Colors.green);

//         setState(() {
//           selectedAddressType = null;
//         });

//         cityController.clear();
//         blockController.clear();
//         buildingNumberController.clear();
//         mobileController.clear();
//       } else {
//         print("❌ Failed");

//         showTopSnack(data["message"] ?? "Failed", Colors.red);
//       }
//     } catch (e) {
//       print("🔥 Exception: $e");

//       showTopSnack("Error: $e", Colors.red);
//     }
//   }

//   void showTopSnack(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
//         backgroundColor: color,
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFAF8F5),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffFAF8F5),
//         title: MyText(
//           text: "Add New Address",
//           size: 24.sp,
//           thisfontWeight: FontWeight.w500,
//           textColor: const Color(0xff2C2C2C),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             SizedBox(height: 10.h),

//             // DropdownButtonFormField<String>(
//             //   value: selectedAddressType,
//             //   decoration: InputDecoration(
//             //     hintText: "Address Type",
//             //     filled: true,
//             //     fillColor: Colors.grey.shade100,
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(12),
//             //       borderSide: BorderSide.none,
//             //     ),
//             //   ),
              
//             //   items: const [
//             //     DropdownMenuItem(
//             //       value: "Home",
//             //       child: Text("Home"),
//             //     ),
//             //     DropdownMenuItem(
                  
//             //       value: "Work",
//             //       child: Text("Work"),
//             //     ),
//             //   ],
//             //   onChanged: (value) {
//             //     setState(() {
//             //       selectedAddressType = value;
//             //     });
//             //   },
//             // ),
// DropdownButtonHideUnderline(

//   child: DropdownButton2<String>(
//     isExpanded: true,
    
//     value: selectedAddressType,

//     hint: const Text("Address Type"),

//     items: ["Home", "Work"]
//         .map(
//           (item) => DropdownMenuItem<String>(
//             value: item,
//             child: Text(item),
//           ),
//         )
//         .toList(),

//     onChanged: (value) {
//       setState(() {
//         selectedAddressType = value;
//       });
//     },

//     buttonStyleData: ButtonStyleData(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color:Color(0xff5C6B4A).withOpacity(.4),
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),

//     dropdownStyleData: DropdownStyleData(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),

//       padding: const EdgeInsets.all(8),
//     ),

//     menuItemStyleData: MenuItemStyleData(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 8,
//       ),
//     ),
//   ),
// ),
//             SizedBox(height: 10.h),

//             MyTextForm(
//               hint: "City",
//               suffix: false,
//               c: cityController,
//             ),
//             SizedBox(height: 10.h),

//             MyTextForm(
//               hint: "Block",
//               suffix: false,
//               c: blockController,
//             ),
//             SizedBox(height: 10.h),

//             MyTextForm(
//               hint: "Building Number",
//               suffix: false,
//               c: buildingNumberController,
//             ),
//             SizedBox(height: 10.h),

//             MyTextForm(
//               hint: "Mobile",
//               suffix: false,
//               c: mobileController,
//             ),

//             SizedBox(height: 30.h),

//             InkWell(
//               onTap: saveAddress,
//               child: Mybutton(
//                 text: "Save Address",
//                 s: 22,
//                 h: 37,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





























import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommere2/data/cubit/addressCubit.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController buildingNumberController =
      TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  String? selectedAddressType;

  bool isLoading = false;

  @override
  void dispose() {
    cityController.dispose();
    blockController.dispose();
    buildingNumberController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> saveAddress() async {
    if (selectedAddressType == null ||
        cityController.text.isEmpty ||
        blockController.text.isEmpty ||
        buildingNumberController.text.isEmpty ||
        mobileController.text.isEmpty) {
      showTopSnack("Please fill all fields", Colors.orange);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final url = Uri.parse(
        "https://tullana.toldpath.com/api/customer/profile/address/add",
      );

      final body = {
        "address_type": selectedAddressType,
        "city": cityController.text,
        "block": blockController.text,
        "building_number": buildingNumberController.text,
        "mobile": mobileController.text,
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        showTopSnack(
          data["message"] ?? "Address added successfully",
          Colors.green,
        );


        setState(() {
          selectedAddressType = null;
        });

        cityController.clear();
        blockController.clear();
        buildingNumberController.clear();
        mobileController.clear();
          Navigator.pop(context, true); 
        // AddressCubit.getAddresse;
      } else {
        showTopSnack(
          data["message"] ?? "Failed to add address",
          Colors.red,
        );
      }
    } catch (e) {
      showTopSnack("Something went wrong", Colors.red);
    }

    setState(() {
      isLoading = false;
    });
  }

  void showTopSnack(String message, Color color) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 60,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),

      appBar: AppBar(
        backgroundColor: const Color(0xffFAF8F5),
        elevation: 0,

        title: MyText(
          text: "Add New Address",
          size: 24.sp,
          thisfontWeight: FontWeight.w500,
          textColor: const Color(0xff2C2C2C),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
          
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  value: selectedAddressType,
          
                  hint: const Text("Address Type"),
          
                  items: ["Home", "Work"]
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
          
                  onChanged: (value) {
                    setState(() {
                      selectedAddressType = value;
                    });
                  },
          
                  buttonStyleData: ButtonStyleData(
                    height: 60,
          
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
          
                    decoration: BoxDecoration(
                      color: const Color(0xff5C6B4A).withOpacity(.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
          
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
          
                    padding: const EdgeInsets.all(8),
                  ),
          
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
          
              SizedBox(height: 10.h),
          
              MyTextForm(
                hint: "City",
                suffix: false,
                c: cityController,
              ),
          
              SizedBox(height: 10.h),
          
              MyTextForm(
                hint: "Block",
                suffix: false,
                c: blockController,
              ),
          
              SizedBox(height: 10.h),
          
              MyTextForm(
                hint: "Building Number",
                suffix: false,
                c: buildingNumberController,
              ),
          
              SizedBox(height: 10.h),
          
              MyTextForm(
                hint: "Mobile",
                suffix: false,
                c: mobileController,
              ),
          
              SizedBox(height: 30.h),
          
              InkWell(
                onTap: isLoading ? null : saveAddress,
          
                child: Container(
                  width: double.infinity,
                  height: 37.h,
          
                  decoration: BoxDecoration(
                    color: const Color(0xff5C6B4A),
                    borderRadius: BorderRadius.circular(14),
                  ),
          
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Mybutton(
                            text: "Save Address",
                            s: 22,
                            h: 37,
                          ),
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