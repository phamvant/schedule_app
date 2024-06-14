import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateMask {
  final TextEditingController textController = TextEditingController();
  final MaskTextInputFormatter formatter;
  final FormFieldValidator<String>? validator;
  final TextInputType textInputType;

  DateMask({
    this.validator,
    required this.formatter,
    required this.textInputType,
  });
}

class AddForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<AddFormState> formStateKey;
  final int idx;
  const AddForm(
      {super.key,
      required this.formKey,
      required this.formStateKey,
      required this.idx});

  @override
  State<AddForm> createState() => AddFormState();
}

class AddFormState extends State<AddForm> {
  late final _formKey;
  late final _formStateKey;
  late final int _idx;
  late DateTime _assignDate;
  late String _docNum;
  late String _company;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _formStateKey = widget.formStateKey;
    _formKey = widget.formKey;
    _idx = widget.idx;
  }

  Map<String, dynamic> getFormData() {
    return {
      'assignDate': _assignDate.toIso8601String(),
      'docNum': _docNum,
      'company': _company,
      'dueDate': _dueDate.toIso8601String(),
      'color': 0,
      'isDone': 0
    };
  }

  String? _validateDueDate(String? value) {
    {
      if (value == null || value.isEmpty) {
        return "";
      }
      final components = value.split("/");
      if (components.length == 3) {
        final day = int.tryParse(components[0]);
        final month = int.tryParse(components[1]);
        final year = int.tryParse(components[2]);
        if (day != null && month != null && year != null) {
          final date = DateTime(year, month, day);
          if (year < 1900) {
            return "";
          }
          if (date.year == year && date.month == month && date.day == day) {
            if (date.difference(_assignDate).inDays < 1) {
              return "";
            }

            _dueDate = date;
            return null;
          }
        }
      }
      return "";
    }
  }

  final DateMask assignDateMask = DateMask(
    formatter: MaskTextInputFormatter(mask: "##/##/####"),
    textInputType: TextInputType.datetime,
  );

  String? _validateAssignDate(String? value) {
    {
      if (value == null || value.isEmpty) {
        return "";
      }
      final components = value.split("/");
      if (components.length == 3) {
        final day = int.tryParse(components[0]);
        final month = int.tryParse(components[1]);
        final year = int.tryParse(components[2]);
        if (day != null && month != null && year != null) {
          final date = DateTime(year, month, day);
          if (year < 1900) {
            return "";
          }
          if (date.year == year && date.month == month && date.day == day) {
            _assignDate = date;
            return null;
          }
        }
      }
      return "";
    }
  }

  final DateMask dueDateMask = DateMask(
    formatter: MaskTextInputFormatter(mask: "##/##/####"),
    textInputType: TextInputType.datetime,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: _idx == 20
              ? const EdgeInsets.symmetric(vertical: 50)
              : const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade700)),
                child: Center(
                    child: Text(
                  _idx.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                )),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: assignDateMask.textController,
                  inputFormatters: [
                    const UpperCaseTextFormatter(),
                    assignDateMask.formatter
                  ],
                  autocorrect: false,
                  keyboardType: assignDateMask.textInputType,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateAssignDate,
                  decoration: const InputDecoration(
                    labelText: "Ngày nhận",
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 0,
                    ),
                    hintText: "dd/mm/yyyy",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    labelText: 'Số văn bản',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    _docNum = value;
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 600,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Công ty',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 0,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    _company = value;
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: dueDateMask.textController,
                  inputFormatters: [
                    const UpperCaseTextFormatter(),
                    dueDateMask.formatter
                  ],
                  autocorrect: false,
                  keyboardType: dueDateMask.textInputType,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateDueDate,
                  decoration: const InputDecoration(
                    labelText: "Ngày tới hạn",
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 0,
                    ),
                    hintText: "dd/mm/yyyy",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter implements TextInputFormatter {
  const UpperCaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
