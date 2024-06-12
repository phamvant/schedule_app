import 'dart:ui';

class Task {
  final int _idx = 1;
  final DateTime _assignDate;
  final String _docNum;
  final String _company;
  final DateTime _dueDate;
  bool isDone = false;

  final Color _color;

  Task(
    this._assignDate,
    this._docNum,
    this._company,
    this._dueDate,
    this._color,
  );

  int get idx => _idx;
  DateTime get assignDate => _assignDate;
  String get docNum => _docNum;
  String get company => _company;
  DateTime get dueDate => _dueDate;
  Color get color => _color;
}
