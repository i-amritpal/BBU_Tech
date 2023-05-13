import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  ToDoTile(
      {Key? key,
      required this.taskName,
      required this.taskStatus,
      required this.onChanged,
      required this.deleteTask})
      : super(key: key);

  final String taskName;
  final bool taskStatus;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Colors.red[400]!,
              borderRadius: BorderRadius.circular(6),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Checkbox(value: taskStatus, onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskStatus
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
