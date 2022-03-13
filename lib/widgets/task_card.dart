import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/task.dart';

class TaskCard extends StatelessWidget {
  Task? task;
  Function(int) onDelete = (int id) {};
  Function(int) onEdit = (int id) {};

  TaskCard(Task _task, Function(int) _onDelete, Function(int) _onEdit,
      {Key? key})
      : super(key: key) {
    task = _task;
    onDelete = _onDelete;
    onEdit = _onEdit;
  }

  void editTask(BuildContext context) {
    onEdit(task!.id);
  }

  void deleteTask(BuildContext context) {
    onDelete(task!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: editTask,
                backgroundColor: const Color.fromARGB(255, 229, 229, 229),
                foregroundColor: Colors.black,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: deleteTask,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Icon(
                  Icons.notifications,
                  color: task!.setReminder
                      ? const Color.fromARGB(255, 252, 163, 17)
                      : Colors.white,
                  size: 25,
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        task!.taskName,
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            task!.scheduledDateTimeString,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(150, 229, 229, 229)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
