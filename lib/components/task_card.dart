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
      height: 140,
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
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.blueAccent,
            //       borderRadius: BorderRadius.circular(10)),
            //   width: 40,
            //   height: 40,
            //   child: Center(
            //       child: Text(
            //     "${task.idx}",
            //     style: const TextStyle(color: Colors.white, fontSize: 20),
            //   )),
            //   // width: double.infinity,
            //   // height: double.infinity,
            // ),
            // Divide(),

            // Divide(),
            Expanded(
              // width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "#13248384",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Divide(isHorizontal: true),
                  Text(
                    // task.docNum,
                    "when low sing daily merely am team describe held pull due atomic maybe page jack before harbor ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Divide(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nhận",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          DateFormat.yMd().format(task.assignDate),
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hạn",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        child: Text(
                          DateFormat.yMd().format(task.dueDate),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded(
            //   // width: 700,
            //   child: Text(
            //     task.company,
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 18,
            //       color: Colors.grey.shade700,
            //     ),
            //   ),
            // ),
            // const Divide(),

            Divide(),
            Container(
              decoration: BoxDecoration(
                  color: task.isDone == 1 ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(10)),
              width: 40,
              height: 40,
              child: Center(
                  child: Text(
                task.isDone == 1 ? "v" : "x",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class Divide extends StatelessWidget {
  bool? _isHorizontal = false;

  Divide({super.key, bool? isHorizontal}) : _isHorizontal = isHorizontal;

  @override
  Widget build(BuildContext context) {
    if (_isHorizontal != null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 0.5,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade800),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: 0.5,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade800),
      );
    }
  }
}
