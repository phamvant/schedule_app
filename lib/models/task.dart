import 'dart:ui';

class Task {
  int _idx = 1;
  DateTime _assignDate;
  String _docNum;
  String _company;
  DateTime _dueDate;
  bool isDone = false;

  Color _color;

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
