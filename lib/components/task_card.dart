import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  late Task task;

  TaskCard(this.task, {super.key});

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 120,
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 255, 217, 0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(31, 128, 127, 127),
            offset: Offset(4, 4),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              width: 40,
              height: 40,
              child: Center(
                  child: Text(
                "${task.idx}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )),
              // width: double.infinity,
              // height: double.infinity,
            ),
            const Divide(),
            SizedBox(
              width: 100,
              child: Text(
                DateFormat.yMd().format(task.assignDate),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const Divide(),
            SizedBox(
              width: 100,
              child: Text(
                task.docNum,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const Divide(),
            Expanded(
              // width: 700,
              child: Text(
                task.company,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const Divide(),
            SizedBox(
              // width: 200,
              child: Text(
                DateFormat.yMd().format(task.dueDate),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const Divide(),
            Container(
              decoration: BoxDecoration(
                  color: task.isDone ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(10)),
              width: 40,
              height: 40,
              child: Center(
                  child: Text(
                task.isDone ? "v" : "x",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class Divide extends StatelessWidget {
  const Divide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: 0.5,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade800),
    );
  }
}
