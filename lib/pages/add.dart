import 'package:flutter/material.dart';
import 'package:memo/components/form.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final int formCount = 20;
  final List<GlobalKey<FormState>> _formKeys = [];

  @override
  void initState() {
    super.initState();
    // Initialize a list of GlobalKeys for the forms
    for (int i = 0; i < formCount; i++) {
      _formKeys.add(GlobalKey<FormState>());
    }
  }

  void _submitAllForms() {
    bool allValid = true;
    for (var key in _formKeys) {
      if (key.currentState?.validate() == false) {
        allValid = false;
      }
    }
    if (allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('All forms are valid and processing data')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the forms')),
      );
    }
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
            onPressed: () {
              _submitAllForms();
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
                                formKey: _formKeys[index],
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 50),
                          itemCount: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
