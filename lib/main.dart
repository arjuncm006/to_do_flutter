import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled4/dem.dart';

import 'package:untitled4/home_page.dart';

void main () async{
  await Hive.initFlutter();

  var box = await Hive.openBox("mybox");
  runApp(MyApp());

}




class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter dempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home_Page(),
    );
  }
}