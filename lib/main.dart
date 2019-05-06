import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/UI/MainPage.dart';
import 'package:flutter_assignment_03/UI/NewSubject.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => main_page(),
        "/newsubject": (context) => NewSubject()
      },
    );
  }
}
