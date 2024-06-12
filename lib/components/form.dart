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
  const AddForm({super.key, required this.formKey});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  late final _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
  }

  final DateMask assignDateMask = DateMask(
      formatter: MaskTextInputFormatter(mask: "##/##/####"),
      textInputType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
        }
        final components = value.split("/");
        if (components.length == 3) {
          final day = int.tryParse(components[0]);
          final month = int.tryParse(components[1]);
          final year = int.tryParse(components[2]);

          if (day != null && month != null && year != null) {
            if (year < 1900) {
              return "";
            }
            final date = DateTime(year, month, day);
            if (date.year == year && date.month == month && date.day == day) {
              return null;
            }
          }
        }
        return "";
      });

  final DateMask dueDateMask = DateMask(
      formatter: MaskTextInputFormatter(mask: "##/##/####"),
      textInputType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
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
              return null;
            }
          }
        }
        return "";
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: assignDateMask.textController,
                inputFormatters: [
                  const UpperCaseTextFormatter(),
                  assignDateMask.formatter
                ],
                // strutStyle: StrutStyle(height: 2),
                autocorrect: false,
                keyboardType: assignDateMask.textInputType,
                autovalidateMode: AutovalidateMode.always,
                validator: assignDateMask.validator,
                decoration: const InputDecoration(
                  labelText: "Ngày nhận",
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 0,
                  ),
                  hintText: "dd/mm/yyyy",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số văn bản',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a document number';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 600,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Công ty',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company';
                  }
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
                autovalidateMode: AutovalidateMode.always,
                validator: dueDateMask.validator,
                decoration: const InputDecoration(
                  labelText: "Ngày tới hạn",
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 0,
                  ),
                  hintText: "dd/mm/yyyy",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ],
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
