import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  int id = 0;
  late String taskName = '';
  late DateTime scheduledDateTime = DateTime.now();
  late String scheduledDateTimeString = formatter.format(scheduledDateTime);
  late bool setReminder = false;

  Task(String _taskName, DateTime _scheduledDateTime, bool _setReminder) {
    taskName = _taskName;
    scheduledDateTime = _scheduledDateTime;
    scheduledDateTimeString = formatter.format(_scheduledDateTime);
    setReminder = _setReminder;
  }

  Task.withId(int _id, String _taskName, DateTime _scheduledDateTime,
      bool _setReminder) {
    id = _id;
    taskName = _taskName;
    scheduledDateTime = _scheduledDateTime;
    scheduledDateTimeString = formatter.format(_scheduledDateTime);
    setReminder = _setReminder;
  }

  Task.fromMap(Map map) {
    id = map['id'];
    taskName = map['taskName'];
    scheduledDateTimeString = map['scheduledDateTime'];
    scheduledDateTime = DateTime.parse(scheduledDateTimeString);
    setReminder = map['setReminder'] == 1;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> taskMap = {
      "taskName": taskName,
      "scheduledDateTime": scheduledDateTimeString,
      "setReminder": setReminder ? 1 : 0
    };

    if (id > 0) {
      taskMap['id'] = id;
    }

    return taskMap;
  }
}
