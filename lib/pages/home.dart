import 'package:flutter/material.dart';
import 'package:memo/helper/sqlite.dart';
import 'package:memo/models/task.dart';
import 'package:memo/components/task_card.dart';

import '../services/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePage> {
  late List<Task> _taskList = [];
  late List<Task> _warningList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var db = DatabaseHelper();
    await db.database;

    var tasks = await db.getTasks();
    setState(() {
      var warningList =
          tasks.where((task) => task.duration < 7 && task.isDone == 0).toList();
      warningList.sort((a, b) => a.duration.compareTo(b.duration));
      _warningList = warningList;

      _taskList = tasks
          .where((task) => task.duration > 7 && task.isDone == 0)
          .toList()
          .reversed
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Colors.grey.shade100,
        surfaceTintColor: Colors.transparent,
        title: const Text("Nhắc lịch văn bản"),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(0.95, 0.95),
        child: FloatingActionButton.large(
          onPressed: () {
            setState(() {
              Navigator.of(context)
                  .push(createRoute())
                  .then((val) => getData());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(
            left: width > 1700 ? width * 0.13 : width * 0.03,
            right: width > 1700 ? width * 0.13 : width * 0.03,
            // top: 50,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _taskList.length,
                          itemBuilder: (context, item) => TaskCard(
                            onDialogClose: getData,
                            updateHomeData: getData,
                            _taskList[item],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _warningList.length,
                          itemBuilder: (context, item) => TaskCard(
                            onDialogClose: getData,
                            updateHomeData: getData,
                            _warningList[item],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
