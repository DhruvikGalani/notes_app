// import 'package:flutter/material.dart';
//
// class tryclass extends StatelessWidget {
//   const tryclass({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Container(
//               padding:
//                   EdgeInsets.only(top: 30.0, bottom: 0, left: 20, right: 20),
//               child: TextField(
//                   controller: headController,
//                   style: TextStyle(
//                       color: Colors.white), // Text color in the TextField
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                     labelStyle: TextStyle(
//                         color: Colors.grey, fontSize: 40), // Label text color
//                     hintText: 'Type something here',
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor:
//                         Colors.transparent, // Transparent background color
//                     contentPadding: EdgeInsets.only(
//                         left: 3.0, right: 3, top: 60), // Padding around text
//                   ),
//                   maxLines: 3),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                     30.0), // Border radius for the container
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black,
//                     Colors.grey.shade800.withOpacity(.89)
//                   ], // Gradient colors
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.purple.withOpacity(0.4),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 0), // Shadow position
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Expanded(
//               child: Container(
//                 padding:
//                     EdgeInsets.only(top: 30.0, bottom: 0, left: 20, right: 20),
//                 child: TextField(
//                     controller: descController,
//                     style: TextStyle(
//                         color: Colors.white), // Text color in the TextField
//                     decoration: InputDecoration(
//                       labelText: 'Description',
//                       labelStyle: TextStyle(
//                           color: Colors.grey, fontSize: 35), // Label text color
//                       hintText: 'Type something here',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor:
//                           Colors.transparent, // Transparent background color
//                       contentPadding: EdgeInsets.only(
//                           left: 3.0, right: 3, top: 60), // Padding around text
//                     ),
//                     maxLines: null),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(
//                       30.0), // Border radius for the container
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black,
//                       Colors.grey.shade800.withOpacity(.89)
//                     ], // Gradient colors
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.purple.withOpacity(0.4),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 0), // Shadow position
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
