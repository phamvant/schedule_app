import 'package:flutter/material.dart';

import '../components/task_card.dart';
import '../helper/sqlite.dart';
import '../models/task.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  late List<Task> _doneList = [];

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
      _doneList = tasks.where((task) => task.isDone == 1).toList();
      _doneList.sort((b, a) => a.doneTime!.compareTo(b.doneTime!));
    });
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Colors.grey.shade100,
        surfaceTintColor: Colors.transparent,
        title: const Text("Đã hoàn thành"),
      ),
      body: Padding(
          padding: EdgeInsets.only(
            left: width > 1700 ? width * 0.13 : width * 0.03,
            right: width > 1700 ? width * 0.13 : width * 0.03,
            // top: 50,
          ),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _doneList.length,
                      itemBuilder: (context, item) => TaskCard(
                        onDialogClose: getData,
                        updateHomeData: getData,
                        _doneList[item],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
