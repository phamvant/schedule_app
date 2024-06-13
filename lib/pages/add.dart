import 'package:flutter/material.dart';
import 'package:memo/components/form.dart';
import 'package:path_provider/path_provider.dart';

import '../helper/sqlite.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final int formCount = 2;
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
    await db.getTasks();
  }

  Future<bool> _submitAllForms() async {
    bool isSubmit = false;
    for (int i = 0; i < formCount; i++) {
      if (_formKeys[i].currentState?.validate() == false) {
        continue;
      } else {
        add(_formStateKeys[i].currentState!.getFormData());
        isSubmit = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Đã lưu ghi chú')));
      }
    }
    return isSubmit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Tạo ghi chú'),
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 200, right: 200, top: 100),
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.separated(
                          itemBuilder: (context, index) => AddForm(
                                key: _formStateKeys[index],
                                formKey: _formKeys[index],
                                formStateKey: _formStateKeys[index],
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 50),
                          itemCount: formCount),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
