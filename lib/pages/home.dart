import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/services/db_helper.dart';
import 'package:todo_list/services/task.dart';
import 'package:todo_list/widgets/task_card.dart';
import '../widgets/task_form.dart';

class Home extends StatefulWidget {
  DbHelper? dbHelper;

  Home({Key? key, required this.dbHelper}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> taskList = [];

  @override
  void initState() {
    super.initState();

    getAllTasks();
  }

  Future<void> getAllTasks() async {
    List<Task> allTaskList = await widget.dbHelper!.getAllTasks();

    setState(() {
      taskList = allTaskList;
    });
  }

  Future<void> insertTask(Task newTask) async {
    await widget.dbHelper!.insertTask(newTask);

    getAllTasks();
  }

  Future<void> deleteTask(int id) async {
    int deletedRow = await widget.dbHelper!.deleteTask(id);

    if (deletedRow > 0) {
      setState(() {
        taskList.removeWhere((task) => task.id == id);
      });
    }
  }

  Future<void> editTask(int id) async {
    Task taskToEdit = taskList.singleWhere((task) => task.id == id);

    Task editedTask = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return TaskForm.edit(task: taskToEdit);
        });

    int editedRow = await widget.dbHelper!.editTask(editedTask);

    if (editedRow > 0) {
      setState(() {
        taskToEdit = editedTask;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 33, 61),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Color.fromARGB(255, 20, 33, 61),
              floating: true,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Task Tracker",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return TaskCard(taskList[index], deleteTask, editTask);
              }, childCount: taskList.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 252, 163, 17),
        onPressed: () async {
          Task newTask = await showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return TaskForm();
              });

          await insertTask(newTask);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
