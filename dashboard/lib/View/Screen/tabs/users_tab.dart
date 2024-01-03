// import 'package:cnp_dashboard/BusinessLogic/Controller/home_page_controller.dart';
// import 'package:cnp_dashboard/Core/Theme/colors.dart';
// import 'package:cnp_dashboard/Model/user.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// class UsersTab extends StatelessWidget {
//   UsersTab({
//     super.key,
//   });

//   final controller = Get.put(UsersController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       var outlineInputBorder = OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         borderSide: const BorderSide(
//           color: ColorManager.primaryC,
//         ),
//       );
//       var inputDecoration = InputDecoration(
//         prefixIcon: const Icon(
//           CupertinoIcons.search,
//           color: ColorManager.primaryC,
//           size: 30,
//         ),
//         border: InputBorder.none,
//         hintText: "Search for users",
//         enabledBorder: outlineInputBorder,
//         errorBorder: outlineInputBorder,
//         focusedBorder: outlineInputBorder,
//         disabledBorder: outlineInputBorder,
//         focusedErrorBorder: outlineInputBorder,
//         filled: true,
//         fillColor: ColorManager.accentColor,
//       );
//       return SizedBox(
//         width: Get.width,
//         height: Get.height,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: TextFormField(
//                   onChanged: (val) => controller.setSearchVal(val),
//                   decoration: inputDecoration,
//                 ),
//               ),
//               const SizedBox(
//                 height: 3,
//               ),
//               StreamBuilder(
//                 stream: controller.userStream(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text("No results"));
//                   } else {
//                     List<UserModel> users = snapshot.data!;
//                     return Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 16.0),
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                     color: ColorManager.accentColor,
//                                     border: Border.all(
//                                         color: ColorManager.primaryC),
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: Text(
//                                     "Total users: ${users.length.toString()}"),
//                               ),
//                             ),
//                           ],
//                         ),
//                         usersBodyBuilder(users, outlineInputBorder),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Padding usersBodyBuilder(
//       List<UserModel> users, OutlineInputBorder outlineInputBorder) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: users.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           var user = users[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.primaryC,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               width: Get.width,
//               height: 50,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: ColorManager.accentColor,
//                   border: Border.all(color: ColorManager.primaryC),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           child: user.imgUrl == null || user.imgUrl == ''
//                               ? const Icon(
//                                   CupertinoIcons.person_alt_circle,
//                                   size: 40,
//                                 )
//                               : Image.network(user.imgUrl ?? ""),
//                         ),
//                         title: Text(users[index].name ?? "unknown"),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       onPressed: () async {
//                         showNotificationDialog(
//                             context, outlineInputBorder, user);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         elevation: 4.0,
//                         padding: const EdgeInsets.all(16.0),
//                         primary: ColorManager.primaryC,
//                         onPrimary: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                       ),
//                       child: const Text("Send notification"),
//                     ),
//                     const SizedBox(width: 8),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<dynamic> showNotificationDialog(BuildContext context,
//       OutlineInputBorder outlineInputBorder, UserModel user) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         content: SizedBox(
//           height: Get.height * 0.4,
//           width: Get.width * 0.5,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextField(
//                   onChanged: (val) => controller.setnotificationTitle(val),
//                   decoration: InputDecoration(
//                     hintText: "Notification title",
//                     border: outlineInputBorder,
//                   )),
//               TextField(
//                 onChanged: (val) => controller.setnotificationBody(val),
//                 decoration: InputDecoration(
//                   hintText: "Notification body",
//                   border: outlineInputBorder,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               ElevatedButton(
//                 onPressed: () async {
//                   Navigator.of(context).pop();

//                   if (await controller.notifyUser(user.token ?? "")) {
//                     Get.snackbar(
//                       "Notification sent",
//                       "",
//                       backgroundColor: ColorManager.accentColor,
//                       icon: const Icon(
//                         Icons.task_alt,
//                         color: Colors.green,
//                         size: 50,
//                       ),
//                     );
//                   } else {
//                     Get.snackbar("Failed to send notification", "",
//                         backgroundColor: Colors.redAccent);
//                   }
//                 },
//                 child: const Text("Send"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
