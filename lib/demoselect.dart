// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<Map> items = [
//     {"id": 1, "name": "name1", "type": "Both", "count": 1},
//     {"id": 2, "name": "name2", "type": "Both", "count": 2},
//     {"id": 3, "name": "name1", "type": "Both", "count": 3},
//     {"id": 4, "name": "name3", "type": "Both", "count": 4},
//     {"id": 5, "name": "name1", "type": "Both", "count": 5},
//     {"id": 6, "name": "name2", "type": "Both", "count": 6},
//     {"id": 7, "name": "name1", "type": "Both", "count": 7},
//     {"id": 8, "name": "name3", "type": "Both", "count": 8},
//     {"id": 9, "name": "name1", "type": "Both", "count": 9},
//     {"id": 10, "name": "name2", "type": "Both", "count": 10},
//     {"id": 11, "name": "name1", "type": "Both", "count": 11},
//     {"id": 12, "name": "name3", "type": "Both", "count": 12},
//   ];
//   List<Map> selectedItems = [];
//   bool isSelecting = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: selectedItems.isEmpty
//             ? Text('Multi Selection Demo')
//             : Text('${selectedItems.length} selected'),
//         actions: selectedItems.isEmpty
//             ? []
//             : [
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Confirm Delete'),
//                         content: Text(
//                             'Are you sure you want to delete selected items?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 items.removeWhere(
//                                     (item) => selectedItems.contains(item));
//                                 selectedItems.clear();
//                                 isSelecting = false; // Exit selection mode
//                               });
//                               Navigator.pop(context);
//                             },
//                             child: Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           final isSelected = selectedItems.contains(item);
//
//           return GestureDetector(
//             onTap: () {
//               if (isSelecting) {
//                 setState(() {
//                   if (isSelected) {
//                     selectedItems.remove(item);
//                     if (selectedItems.isEmpty) {
//                       isSelecting = false; // Exit selection mode
//                     }
//                   } else {
//                     selectedItems.add(item);
//                   }
//                 });
//               }
//               print("items : $items");
//               print("item : $item");
//               print("selectedItems  : $selectedItems");
//               print("isselecting  : $isSelecting");
//             },
//             onLongPress: () {
//               setState(() {
//                 isSelecting = true; // Enter selection mode
//                 if (!isSelected) {
//                   selectedItems.add(item);
//                 }
//               });
//               print("items : $items");
//               print("item : $item");
//               print("selectedItems  : $selectedItems");
//               print("isselecting  : $isSelecting");
//             },
//             child: ListTile(
//               title: Text("id : ${items[index]['id']}"),
//               tileColor: isSelected ? Colors.blue.withOpacity(0.5) : null,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
