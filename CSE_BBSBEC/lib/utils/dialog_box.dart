import 'package:flutter/material.dart';

import '../components/my_button.dart';
import 'my_button.dart';

//ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  DialogBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[50],
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get Task
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  hintText: "\"Enter new Notification\""),
              keyboardType: TextInputType.text,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtonNotification(name: 'Cancel', onPressed: onCancel),
                const SizedBox(width: 8),
                MyButtonNotification(name: 'Save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
