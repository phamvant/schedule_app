import 'package:flutter/material.dart';
import 'package:memo/components/form.dart';

import '../helper/sqlite.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final int formCount = 20;
  final List<GlobalKey<FormState>> _formKeys = [];
  final List<GlobalKey<AddFormState>> _formStateKeys = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < formCount; i++) {
      _formKeys.add(GlobalKey<FormState>());
      _formStateKeys.add(GlobalKey<AddFormState>());
    }
  }

  void add(formData) async {
    var db = DatabaseHelper();
    await db.database;
    await DatabaseHelper().insertForm(formData);
  }

  Future<bool> _submitAllForms() async {
    bool isSubmit = false;
    for (int i = 0; i < formCount; i++) {
      if (_formKeys[i].currentState?.validate() == false) {
        continue;
      } else {
        if (_formStateKeys[i].currentState != null) {
          add(_formStateKeys[i].currentState?.getFormData());
          isSubmit = true;
        }
      }
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Đã lưu ghi chú')));
    return isSubmit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: const Text('Tạo ghi chú'),
          toolbarHeight: 100,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
        ),
        floatingActionButton: Align(
          alignment: const Alignment(0.95, 0.95),
          child: FloatingActionButton.large(
            onPressed: () async {
              if (await _submitAllForms()) {
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.save),
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200),
              child: Container(
                padding: const EdgeInsets.only(left: 50, right: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(236, 255, 255, 255),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(31, 128, 127, 127),
                      offset: Offset(4, 4),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.builder(
                            itemBuilder: (context, index) => AddForm(
                                  key: _formStateKeys[index],
                                  formKey: _formKeys[index],
                                  formStateKey: _formStateKeys[index],
                                  idx: index + 1,
                                ),
                            itemCount: formCount),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
