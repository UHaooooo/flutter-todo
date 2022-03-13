import 'package:sqflite/sqflite.dart';
import 'package:todo_list/services/task.dart';

class DbHelper {
  String databasePath = '';
  String taskDbName = 'task.db';
  Database? taskDb;

  Future<void> initDb() async {
    databasePath = await getDatabasesPath();
    String path = databasePath + taskDbName;
    taskDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS task  (id INTEGER PRIMARY KEY AUTOINCREMENT, taskName VARCHAR(50), scheduledDateTime TEXT, setReminder INTEGER)");
    });
  }

  Future<List<Task>> getAllTasks() async {
    List<Map> taskMapList =
        await taskDb!.query('task', orderBy: 'scheduledDateTime');
    List<Task> taskList = [];

    for (var taskMap in taskMapList) {
      taskList.add(Task.fromMap(taskMap));
    }

    return taskList;
  }

  Future<void> insertTask(Task newTask) async {
    await taskDb!.insert('task', newTask.toMap());
  }

  Future<int> deleteTask(int id) async {
    return await taskDb!.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editTask(Task taskToEdit) async {
    return await taskDb!.update('task', taskToEdit.toMap(),
        where: 'id = ?', whereArgs: [taskToEdit.id]);
  }
}
