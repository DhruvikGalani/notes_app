import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_by_sql/getlogicClass.dart';
import 'package:notes_app_by_sql/viewpage.dart';

class InsertPage extends StatefulWidget {
  String? id, date, title, desc;
  InsertPage({this.id, this.title, this.desc, this.date});
  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  TextEditingController headController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date = DateFormat('dd-MM-yyyy').format(selectedDate);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.title != null) {
      headController.text = widget.title!;
      descController.text = widget.desc!;
      date = widget.date!;
    } else {
      headController.text = "";
      descController.text = "";
      date = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
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
            databaseHelper.createDatabase().then((value) async {
              if (widget.title == null) {
                await value.transaction((txn) async {
                  int dbindex = await txn.rawInsert(
                      'INSERT INTO dbTable(heading,desc,date) VALUES("${headController.text}","${descController.text}","$date")');
                  print("idindex : $dbindex");
                  setState(() {});
                });
              } else {
                await value.transaction((txn) async {
                  int dbindex = await txn.rawUpdate(
                      'update dbTable set heading ="${headController.text}",desc ="${descController.text}",date="$date"'
                      'where id = "${widget.id}"');
                  print("idindex : $dbindex");
                  setState(() {});
                });
              }
              databaseHelper.createDatabase().then((value) async {
                await value.transaction((txn) async {
                  records = await txn.rawQuery('select * from dbTable');
                });
                setState(() {});
              }).then((value) {
                setState(() {});
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const mainPage();
                  },
                ));
              });
            });
          },
          icon: Icon(
            Icons.cloud_done_rounded,
            size: 30,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 3,
        scrolledUnderElevation: 7,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            borderSide: BorderSide.none),
        shadowColor: Color(0xff171616),
        backgroundColor: Color(0xff010101),
        leading: IconButton(
          onPressed: () {
            databaseHelper.createDatabase().then((value) async {
              await value.transaction((txn) async {
                records = await txn.rawQuery('select * from dbTable');
              });
            }).then((value) {
              setState(() {});
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const mainPage();
                },
              ));
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
        title: Text(
          'Add Notes',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 20,
            fontFamily: 'varelaRound',
            shadows: [
              Shadow(
                  color: Color(0xff3B3A3A),
                  blurRadius: 1.5,
                  offset: Offset(0, 0)),
            ],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 30.0, bottom: 0, left: 20, right: 20),
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
              child: TextField(
                controller: headController,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 18,
                  fontFamily: 'varelaRound',
                  shadows: const [
                    Shadow(
                        color: Color(0xff3B3A3A),
                        blurRadius: 1.5,
                        offset: Offset(0, 0)),
                  ],
                  fontWeight: FontWeight.w500,
                ), // Text color in the TextField
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontFamily: "varelaRound",
                    fontSize: 40,
                    shadows: [
                      Shadow(
                          color: Color(0xff3B3A3A),
                          blurRadius: 1.5,
                          offset: Offset(0, 0)),
                    ],
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ), // Label text color
                  hintText: 'Type something here',
                  hintStyle: TextStyle(
                    fontFamily: "varelaRound",
                    fontSize: 18,
                    shadows: [
                      Shadow(
                          color: Color(0xff3B3A3A),
                          blurRadius: 1.5,
                          offset: Offset(0, 0)),
                    ],
                    color: const Color(0xff2B2B2B).withOpacity(.4),
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => selectDate(context),
                    splashRadius: 23,
                    splashColor: const Color(0xff2B2B2B),
                    icon: Icon(
                      CupertinoIcons.calendar_today,
                      color: Colors.grey.shade700,
                      shadows: [
                        Shadow(
                            color: Color(0xff303030),
                            blurRadius: 1.5,
                            offset: Offset(0, 0)),
                      ],
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                cursorColor: const Color(0xff2B2B2B),
                cursorOpacityAnimates: true,
                cursorHeight: 18,
                cursorRadius: const Radius.circular(50),
                cursorWidth: 3,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
                height: 470,
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 0, left: 20, right: 20),
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
                child: TextField(
                  controller: descController,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                    fontFamily: 'varelaRound',
                    shadows: const [
                      Shadow(
                          color: Color(0xff3B3A3A),
                          blurRadius: 1.5,
                          offset: Offset(0, 0)),
                    ],
                    fontWeight: FontWeight.w500,
                  ), // Text color in the TextField
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: "varelaRound",
                      fontSize: 35,
                      shadows: [
                        Shadow(
                            color: Color(0xff3B3A3A),
                            blurRadius: 1.5,
                            offset: Offset(0, 0)),
                      ],
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Type something here',
                    hintStyle: TextStyle(
                      fontFamily: "varelaRound",
                      fontSize: 18,
                      shadows: [
                        Shadow(
                            color: Color(0xff3B3A3A),
                            blurRadius: 1.5,
                            offset: Offset(0, 0)),
                      ],
                      color: const Color(0xff2B2B2B).withOpacity(.4),
                      fontWeight: FontWeight.w500,
                    ), // T
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor:
                        Colors.transparent, // Transparent background color
                    contentPadding: const EdgeInsets.only(
                        left: 3.0, right: 3, top: 60), // Padding around text
                  ),
                  cursorColor: const Color(0xff2B2B2B),
                  cursorOpacityAnimates: true,
                  cursorHeight: 18,
                  cursorRadius: const Radius.circular(50),
                  cursorWidth: 3,
                  maxLines: null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
