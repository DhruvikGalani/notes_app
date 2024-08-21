import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_by_sql/InsertPage.dart';
import 'package:notes_app_by_sql/getlogicClass.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    call();

    print("record  :$records");
  }

  void call() {
    databaseHelper.createDatabase().then((value) async {
      await value.transaction((txn) async {
        records = await txn.rawQuery('select * from dbTable');
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color(0xff010101).withOpacity(.04),
          boxShadow: [
            BoxShadow(
                color: Color(0xff010101),
                blurRadius: 1.5,
                offset: Offset(0, 0)),
          ],
          borderRadius: BorderRadius.circular(
              26.0), // Border radius for the container// Gradient colors
        ),
        child: IconButton(
          highlightColor: Color(0xff171616),
          splashColor: Color(0xff171616),
          splashRadius: 33,
          iconSize: 43,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return InsertPage();
              },
            ));
          },
          icon: Icon(
            Icons.add_rounded,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 3,
        scrolledUnderElevation: 7,
        titleTextStyle: TextStyle(
          color: Colors.grey.shade700,
          fontSize: selectedItems.isEmpty ? 35 : 20,
          fontFamily: selectedItems.isEmpty ? 'novaRound' : 'varelaRound',
          shadows: [
            Shadow(
                color: Color(0xff3B3A3A),
                blurRadius: 1.5,
                offset: Offset(0, 0)),
          ],
          fontWeight: FontWeight.w500,
        ),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            borderSide: BorderSide.none),
        shadowColor: Color(0xff171616),
        backgroundColor: Color(0xff010101),
        leading: selectedItems.isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  setState(() {
                    selectedItems.clear();
                    isSelecting = false; // Exit selection mode
                  });
                },
                splashRadius: 23,
                splashColor: const Color(0xff2B2B2B),
                icon: Icon(
                  CupertinoIcons.back,
                  color: Colors.grey.shade700,
                  shadows: [
                    Shadow(
                        color: Color(0xff303030),
                        blurRadius: 1.5,
                        offset: Offset(0, 0)),
                  ],
                ),
              ),
        title: selectedItems.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  ' Notes',
                ),
              )
            : Text(
                '${selectedItems.length} selected',
              ),
        actions: selectedItems.isEmpty
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: IconButton(
                    splashRadius: 23,
                    splashColor: const Color(0xff2B2B2B),
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: Colors.grey.shade700,
                      shadows: [
                        Shadow(
                            color: Color(0xff303030),
                            blurRadius: 1.5,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                        barrierColor: Color(0xff161224).withOpacity(0.40),
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text(
                            'Confirm Delete',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "novaRound",
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to delete selected items?',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontFamily: "varelaRound",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItems.clear();
                                  isSelecting = false; // Exit selection mode
                                });

                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                selectedItems.forEach((element) {
                                  databaseHelper
                                      .createDatabase()
                                      .then((value) async {
                                    await value.transaction((txn) async {
                                      await txn.rawDelete(
                                          'delete from dbTable where id= "${element["id"]}" ');
                                      setState(() {});
                                    });
                                  });
                                  databaseHelper
                                      .createDatabase()
                                      .then((value) async {
                                    await value.transaction((txn) async {
                                      records = await txn.rawQuery(
                                        'select *  from dbTable',
                                      );
                                      setState(() {});
                                    });
                                  });
                                });
                                setState(() {
                                  selectedItems.clear();
                                  isSelecting = false; // Exit selection mode
                                });

                                Navigator.pop(context);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: records.length,
          itemBuilder: (context, index) {
            final item = records[index];

            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
              child: viewIndex_method(index, item),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height - 290),
          ),
        ),
      ),
    );
  }

  Widget viewIndex_method(int index, final item) {
    return GestureDetector(
      onTap: () {
        print("isSelected=+++isSelecting+++$isSelecting");
        if (isSelecting) {
          isSelected = selectedItems
              .any((element) => element['id'] == records[index]['id']);
          print(
              "isSelected=+++${selectedItems.any((element) => element['id'] == records[index]['id'])}");
          if (isSelected) {
            selectedItems.removeWhere(
                (element) => element['id'] == records[index]['id']);
            if (selectedItems.isEmpty) {
              isSelecting = false; // Exit selection mode
            }
          } else {
            selectedItems.add(item);
          }
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return InsertPage(
                title: records[index]['heading'],
                desc: records[index]['desc'],
                date: records[index]['date'],
                id: "${records[index]['id']}",
              );
            },
          ));
        }
        setState(() {});
      },
      onLongPress: () {
        isSelecting = true; // Enter selection mode
        isSelected = selectedItems
            .any((element) => element['id'] == records[index]['id']);
        if (!isSelected) {
          selectedItems.add(item);
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: (selectedItems
                  .any((element) => element['id'] == records[index]['id']))
              ? BoxDecoration(
                  color: Color(0xff010101).withOpacity(.5),
                  borderRadius: BorderRadius.circular(
                      26.0), // Border radius for the container
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red.shade200.withOpacity(.21),
                      Colors.red.shade200.withOpacity(.21),
                    ], // Gradient colors
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff010101),
                        blurRadius: 1.5,
                        offset: Offset(0, 0)),
                  ],
                )
              : BoxDecoration(
                  color: const Color(0xff010101).withOpacity(.04),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff010101),
                        blurRadius: 1.5,
                        offset: Offset(0, 0)),
                  ],
                  borderRadius: BorderRadius.circular(
                      26.0), // Border radius for the container// Gradient colors
                ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${records[index]["heading"]}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "varelaRound",
                      fontSize: 20,
                      shadows: [
                        Shadow(
                            color: Color(0xff3B3A3A),
                            blurRadius: 1.5,
                            offset: Offset(0, 0)),
                      ],
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Divider(
                    color: Colors.grey.shade600,
                    thickness: .3,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        "${records[index]["desc"]}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "varelaRound",
                          fontSize: 16,
                          shadows: [
                            Shadow(
                                color: Color(0xff3B3A3A),
                                blurRadius: 1.5,
                                offset: Offset(0, 0)),
                          ],
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade600,
                    thickness: .2,
                  ),
                  Text(
                    "${records[index]["date"]}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: "varelaRound",
                      fontSize: 12,
                      shadows: [
                        Shadow(
                            color: Color(0xff3B3A3A),
                            blurRadius: 1.5,
                            offset: Offset(0, 0)),
                      ],
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
