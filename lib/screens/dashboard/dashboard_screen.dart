// import 'package:educational_app/constants/colors.dart';
// import 'package:flutter/material.dart';

// import 'navigator_item.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: navigatorItems[currentIndex].screen,
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(15),
//             topLeft: Radius.circular(15),
//           ),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black38.withOpacity(0.1),
//                 spreadRadius: 0,
//                 blurRadius: 37,
//                 offset: const Offset(0, -12)),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//           child: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             currentIndex: currentIndex,
//             onTap: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: kPrimaryColor,
//             selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//             unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//             unselectedItemColor: Colors.black,
//             items: navigatorItems.map((e) {
//               return getNavigationBarItem(
//                   label: e.label, index: e.index, iconPath: e.iconPath);
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   BottomNavigationBarItem getNavigationBarItem(
//       {String? label, String? iconPath, int? index}) {
//     Color iconColor =
//     index == currentIndex ? kPrimaryColor : Colors.black;
//     return BottomNavigationBarItem(
//       label: label,
//       icon: Image.asset(
//         iconPath!,
//         color: iconColor,
//       ),
//     );
//   }
// }
