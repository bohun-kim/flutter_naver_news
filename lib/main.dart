import 'package:flutter/material.dart';
import 'package:flutter_naver_news/screens/mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyNews app',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      home: const MainScreen(),
    );
  }
}
