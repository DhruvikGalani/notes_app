import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app_by_sql/viewpage.dart';

class spleshScreen extends StatefulWidget {
  const spleshScreen({super.key});

  @override
  State<spleshScreen> createState() => _spleshScreenState();
}

class _spleshScreenState extends State<spleshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 3444),
        () async => await Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const mainPage(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171616),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ClipRRect(
              child: Image.asset(
                "asset/img/deathNote.jpg",
                height: 220,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.30),
                color: const Color(0xff171616),
                filterQuality: FilterQuality.high,
                colorBlendMode: BlendMode.difference,
              ),
            ),
            const Spacer(),
            Text(
              'Notes',
              style: TextStyle(
                fontFamily: "novaRound",
                fontSize: 35,
                shadows: const [
                  Shadow(
                      color: Color(0xff3B3A3A),
                      blurRadius: 3.5,
                      offset: Offset(0, 0)),
                ],
                color: const Color(0xff3B3A3A).withOpacity(.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
