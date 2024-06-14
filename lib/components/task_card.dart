import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memo/helper/sqlite.dart';
import '../models/task.dart';

class TaskCard extends StatefulWidget {
  late Task task;
  final VoidCallback onDialogClose;
  final VoidCallback updateHomeData;

  TaskCard(this.task,
      {super.key, required this.onDialogClose, required this.updateHomeData});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  deleteTask() async {
    DatabaseHelper().delete(widget.task.idx);
  }

  toggleDone(int val) async {
    DatabaseHelper().toogleDone(widget.task.idx, val);
  }

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      height: 140,
      decoration: BoxDecoration(
        color: widget.task.colors,
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
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "#${widget.task.docNum}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    // Divide(isHorizontal: true),
                    Expanded(
                      child: Text(
                        // task.docNum,
                        widget.task.company,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divide(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          DateFormat.yMd().format(widget.task.assignDate),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Divide(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hạn",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        child: Text(
                          DateFormat.yMd().format(widget.task.dueDate),
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
            Divide(),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => EditDialog(context),
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        setState(() {
                          widget.task.isDone = widget.task.isDone == 1 ? 0 : 1;
                          toggleDone(widget.task.isDone);
                          widget.updateHomeData();
                        });
                      },
                      icon: widget.task.isDone == 1
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.check_circle_outline_rounded,
                            ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> EditDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SizedBox(
            width: 100,
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton.filled(
                      onPressed: () async {
                        //DELETE BUTTON
                        await deleteTask();
                        Navigator.pop(context);
                        widget.onDialogClose();
                      },
                      icon: const Icon(Icons.delete)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Quay lại'),
                ),
              ],
            ),
          ),
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
