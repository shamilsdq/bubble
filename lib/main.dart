import 'package:bubble_diary/pages/list.dart';
import 'package:flutter/material.dart';
import 'package:bubble_diary/themes.dart';


void main() => runApp(Bubble());


class Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    int date = (now.year * 10000) + (now.month * 100) + now.day;

    return MaterialApp(

      title: 'Bubble - Personal diary app',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      home: EntryList(date: date),

    );

  }
}