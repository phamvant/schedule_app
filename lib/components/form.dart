import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _assignDate;
  late String _docNum;
  late String _company;
  late DateTime _dueDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Ngày nhận'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an assign date';
                }
                _assignDate = DateTime.parse(value);
                return null;
              },
            ),
          ),
          SizedBox(
            width: 200,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Số văn bản'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a document number';
                }
                _docNum = value;
                return null;
              },
            ),
          ),
          SizedBox(
            width: 600,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Công ty'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company';
                }
                _company = value;
                return null;
              },
            ),
          ),
          SizedBox(
            width: 200,
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Ngày đến hạn'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a due date';
                }
                _dueDate = DateTime.parse(value);
                return null;
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       // Create a new task object
          //       Task newTask = Task(
          //         _assignDate,
          //         _docNum,
          //         _company,
          //         _dueDate,
          //         _color,
          //       );

          //       // Handle the new task (e.g., save it to a database, send it to an API, etc.)
          //       print('Task created: ${newTask}');
          //     }
          //   },
          //   child: const Text('Submit'),
          // ),
        ],
      ),
    );
  }
}
