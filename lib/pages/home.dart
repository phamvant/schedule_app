import 'package:flutter/material.dart';
import 'package:memo/models/task.dart';
import 'package:memo/models/data.dart';
import 'package:memo/components/task_card.dart';

import '../services/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePage> {
  late List<Task> taskList;

  @override
  void initState() {
    super.initState();
    taskList = sampleTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Align(
        alignment: const Alignment(0.95, 0.95),
        child: FloatingActionButton.large(
          onPressed: () {
            setState(() {
              Navigator.of(context).push(createRoute());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 250,
          right: 250,
          top: 100,
        ),
        child: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: taskList.length,
                  itemBuilder: (context, item) => TaskCard(
                    taskList[item],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 125, 188, 239),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(createRoute());
      },
      child: const Text(
        "Thêm ghi chú",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
