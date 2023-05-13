import 'package:flutter/material.dart';

//ignore: must_be_immutable
class MyButtonNotification extends StatelessWidget {
  MyButtonNotification({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  final String name;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.white,
        child: Text(
          name,
          style: const TextStyle(color: Colors.deepOrange),
        ),
      ),
    );
  }
}
