// // Navigator.push(
// //   context,
// //   MaterialPageRoute(
// //     builder: (context) => BlocProvider(
// //       create: (context) => AddAddressCubit(),
// //       child: const AddAddressScreen(),
// //     ),
// //   ),
// // );



// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DeliveryAddressScreen extends StatelessWidget {
//   const DeliveryAddressScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // AppBar
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title:  MyText(text:  "Delivery Address",
//          size: 24.sp, thisfontWeight: FontWeight.w600, textColor: Color(0xff2C2C2C)),
//         centerTitle: false,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             _addressCard(
//               title: "Home",
//               isDefault: true,
//               name: "Jane Doe",
//               address: "123 Main Street, Apt 4B",
//               city: "New York, NY 10001",
//               phone: "+1 (555) 123-4567",
//               onEdit: () {},
//               onDelete: () {},
//             ),

//             const SizedBox(height: 12),

//             _addressCard(
//               title: "Work",
//               isDefault: false,
//               name: "Jane Doe",
//               address: "456 Business Ave, Suite 200",
//               city: "New York, NY 10002",
//               phone: "+1 (555) 987-6543",
//               onEdit: () {},
//               onDelete: () {},
//               showSetDefault: true,
//             ),

//             const SizedBox(height: 20),

//             // ===== Add New Address =====
//             OutlinedButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.add),
//               label: const Text("Add New Address"),
//               style: OutlinedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ),

//             const Spacer(),

//             // ===== Continue Button =====
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF5C6B4F),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text(
//                   "Continue",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _addressCard({
//     required String title,
//     required String name,
//     required String address,
//     required String city,
//     required String phone,
//     required VoidCallback onEdit,
//     required VoidCallback onDelete,
//     bool isDefault = false,
//     bool showSetDefault = false,
//   }) {
//     return Container(
//       padding:  EdgeInsets.all(8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: isDefault ? const Color(0xFF5C6B4F) : Colors.grey.shade300,
//           width: isDefault ? 1.5 : 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Row
//           Row(
//             children: [
//                Icon(Icons.location_on_outlined, size: 24.sp),
//               const SizedBox(width: 6),
//               Text(
//                 title,
//                 style:  TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.sp,
//                 ),
//               ),

//               if (isDefault) ...[
//                  SizedBox(width: 8),
//                 Container(
//                   padding:
//                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.h),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF5C6B4F),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child:  Text(
//                     "Default",
//                     style: TextStyle(color: Colors.white, fontSize: 11.sp),
//                   ),
//                 ),
//               ],

//               const Spacer(),

//               IconButton(
//                 onPressed: onEdit,
//                 icon: const Icon(Icons.edit, size: 18),
//               ),
//               IconButton(
//                 onPressed: onDelete,
//                 icon: const Icon(Icons.delete_outline,
//                     size: 18, color: Colors.red),
//               ),
//             ],
//           ),

//           const SizedBox(height: 6),

//           Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
//           const SizedBox(height: 4),
//           Text(address, style: TextStyle(color: Colors.grey.shade700)),
//           Text(city, style: TextStyle(color: Colors.grey.shade700)),
//           const SizedBox(height: 4),
//           Text(phone, style: TextStyle(color: Colors.grey.shade700)),

//           if (showSetDefault) ...[
//             const SizedBox(height: 10),
//             TextButton(
//               onPressed: () {},
//               child: const Text(
//                 "Set as default",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//           ]
//         ],
//       ),
//     );
//   }
// }

















import 'package:ecommere2/data/cubit/addressCubit.dart';
import 'package:ecommere2/data/status/addressStatus.dart';
import 'package:ecommere2/ui/screens/profile/addAddress.dart';
import 'package:ecommere2/ui/screens/profile/editAdress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommere2/ui/widgets/myText.dart';


class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..getAddresses(),
      child: const _DeliveryAddressView(),
    );
  }
}

class _DeliveryAddressView extends StatelessWidget {
  const _DeliveryAddressView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressCubit>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: MyText(
          text: "Delivery Address",
          size: 24.sp,
          thisfontWeight: FontWeight.w600,
          textColor: const Color(0xff2C2C2C),
        ),
      ),

      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {

          if (state is AddressLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AddressError) {
            return Center(child: Text(state.message));
          }

          if (state is AddressLoaded) {
            final list = state.addresses;

            if (list.isEmpty) {
              return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("No addresses yet"),
                    
                  ),
                   SizedBox(height: 24,), 
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                         onPressed: () async {
                       final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddAddressScreen(),
                        ),
                      );
                      
                      if (result == true) {
                        context.read<AddressCubit>().getAddresses(); // 🔥 refresh
                      }
                        if (result == true) {
                          cubit.getAddresses();
                        }
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5C6B4F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Add New Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                                        ),
                    ),              
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = list[index];

                        return _addressCard(
                          title: item.addressType.isEmpty
                              ? "Address"
                              : item.addressType,

                          name: item.title,
                          address: item.street,
                          city: item.city,
                          phone: item.mobile,

                          isDefault: index == 0,

                          onEdit: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditAddressScreen(
        id: item.id,
        addressType: item.addressType,
        city: item.city,
        block: item.street,
        buildingNumber: item.buildingNumber,
        mobile: item.mobile,
      ),
    ),
  );

  if (result == true) {
    cubit.getAddresses(); // 🔥 refresh فوراً
  }
},
                          onDelete: () {},
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

            
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                       onPressed: () async {
                     final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const AddAddressScreen(),
  ),
);

if (result == true) {
  context.read<AddressCubit>().getAddresses(); // 🔥 refresh
}
                      if (result == true) {
                        cubit.getAddresses();
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5C6B4F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Add New Address",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                   SizedBox(height: 20.h),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _addressCard({
    required String title,
    required String name,
    required String address,
    required String city,
    required String phone,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    bool isDefault = false,
  }) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDefault
              ? const Color(0xFF5C6B4F)
              : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Header
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 6),

              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              IconButton(
                onPressed: onEdit,
                icon:  Icon(Icons.edit, size: 24.sp),
              ),

            
            ],
          ),

          const SizedBox(height: 6),

          Text(name,
              style: const TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(height: 4),

          Text(address,
              style: TextStyle(color: Colors.grey.shade700)),

          Text(city,
              style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 4),

          Text(phone,
              style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}