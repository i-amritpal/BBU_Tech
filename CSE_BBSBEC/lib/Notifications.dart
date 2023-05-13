import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../pages/home_page.dart';
import 'main_cse.dart';

void main() async {
  //init hive
  await Hive.initFlutter();

  //open box
  await Hive.openBox('mybox');
  runApp(Notification());
}

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home()
    );
  }
}
