import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todolist extends StatelessWidget {
  Todolist({super.key, required this.taskName, required this.isCompleted, required this.changed, required this.deleteFunction});

  final String taskName;
  final bool isCompleted;
  Function(bool?)? changed;
  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(25.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(12),
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: changed,
                activeColor: Colors.black,
              ),
              Text(taskName),
            ],
          ),
        ),
      ),
    );
  }
}
