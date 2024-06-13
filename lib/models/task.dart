import 'dart:ui';

class Task {
  final int _idx;
  final DateTime _assignDate;
  final String _docNum;
  final String _company;
  final DateTime _dueDate;
  int isDone = 0;
  final int _color;

  Task(
    this._idx,
    this._assignDate,
    this._docNum,
    this._company,
    this._dueDate,
    this._color,
    this.isDone,
  );

  int get idx => _idx;
  DateTime get assignDate => _assignDate;
  String get docNum => _docNum;
  String get company => _company;
  DateTime get dueDate => _dueDate;
  int get color => _color;
}
