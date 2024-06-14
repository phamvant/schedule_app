import 'package:flutter/material.dart';

class Task {
  final int _idx;
  final DateTime _assignDate;
  final String _docNum;
  final String _company;
  final DateTime _dueDate;
  int isDone = 0;
  final int _color;
  late Color _colors;
  late int _duration;
  late DateTime? doneTime;

  Task(this._idx, this._assignDate, this._docNum, this._company, this._dueDate,
      this._color, this.isDone, this.doneTime) {
    var today = new DateTime.now();
    _duration = _dueDate.difference(today).inDays;
    if (_duration > 7 || isDone == 1) {
      _colors = Colors.white;
    } else if (_duration < 3) {
      _colors = Colors.red.shade100;
    } else {
      _colors = Colors.yellow.shade300;
    }
  }

  int get idx => _idx;
  DateTime get assignDate => _assignDate;
  String get docNum => _docNum;
  String get company => _company;
  DateTime get dueDate => _dueDate;
  int get color => _color;
  int get duration => _duration;
  Color get colors => _colors;
}
