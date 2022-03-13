import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/task.dart';

class TaskForm extends StatefulWidget {
  Task? _task;
  bool _editMode = false;

  TaskForm({Key? key}) : super(key: key);

  TaskForm.edit({Key? key, required Task task}) : super(key: key) {
    _task = task;
    _editMode = true;
  }

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final _formKey = GlobalKey<FormState>();

  TextEditingController dateInput = TextEditingController();
  String taskName = '';
  DateTime scheduledDateTime = DateTime.now();
  bool setReminder = false;

  @override
  void initState() {
    if (widget._editMode) {
      taskName = widget._task!.taskName;
      scheduledDateTime = widget._task!.scheduledDateTime;
      setReminder = widget._task!.setReminder;
    } else {
      taskName = '';
      scheduledDateTime = DateTime.now();
      setReminder = false;
    }

    dateInput.text = formatter.format(scheduledDateTime);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Color.fromARGB(20, 229, 229, 229))),
            color: Colors.black),
        height: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Title(
              color: Colors.white,
              child: Text(
                widget._editMode ? 'Edit Task' : 'Create Task',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              cursorColor: const Color.fromARGB(255, 252, 163, 17),
              style: const TextStyle(color: Colors.white),
              initialValue: taskName,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.task,
                  color: Colors.white,
                ),
                border: UnderlineInputBorder(),
                filled: false,
                hintText: 'Enter the task name',
                labelText: 'Task',
                labelStyle: TextStyle(color: Colors.white),
                floatingLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 252, 163, 17),
                ),
                hintStyle: TextStyle(
                  color: Color.fromARGB(150, 229, 229, 229),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 252, 163, 17)),
                ),
                focusColor: Color.fromARGB(255, 252, 163, 17),
              ),
              onChanged: (String value) {
                setState(() {
                  taskName = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter task name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              readOnly: true,
              controller: dateInput,
              textCapitalization: TextCapitalization.sentences,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate:
                      widget._editMode ? scheduledDateTime : DateTime.now(),
                  firstDate: DateTime(0000),
                  lastDate: DateTime(3000),
                );

                if (pickedDate != null) {
                  setState(() {
                    scheduledDateTime = pickedDate;
                    dateInput.text = formatter.format(
                        pickedDate); //set output date to TextField value.
                  });
                }
              },
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                border: UnderlineInputBorder(),
                filled: false,
                hintText: 'Select Date for the task',
                labelText: 'Date',
                labelStyle: TextStyle(color: Colors.white),
                floatingLabelStyle: TextStyle(
                  color: Color.fromARGB(255, 252, 163, 17),
                ),
                hintStyle: TextStyle(
                  color: Color.fromARGB(150, 229, 229, 229),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 252, 163, 17)),
                ),
                focusColor: Color.fromARGB(255, 252, 163, 17),
              ),
            ),
            const SizedBox(height: 20.0),
            SwitchListTile(
              contentPadding: const EdgeInsets.all(0),
              enableFeedback: true,
              activeColor: const Color.fromARGB(255, 252, 163, 17),
              title: const Text(
                'Set Reminder',
                style: TextStyle(color: Colors.white),
              ),
              value: setReminder,
              onChanged: (bool value) {
                setState(() {
                  setReminder = !setReminder;
                });
              },
              secondary: const Icon(
                Icons.circle_notifications,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 252, 163, 17),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget._editMode) {
                    widget._task!.taskName = taskName;
                    widget._task!.scheduledDateTime = scheduledDateTime;
                    widget._task!.scheduledDateTimeString =
                        formatter.format(scheduledDateTime);
                    widget._task!.setReminder = setReminder;

                    Navigator.pop(context, widget._task);
                  } else {
                    Task newTask =
                        Task(taskName, scheduledDateTime, setReminder);

                    Navigator.pop(context, newTask);
                  }
                }
              },
              child: Text(
                widget._editMode ? 'Save' : 'Create',
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
