import 'package:todo/core/core.dart';
import 'package:todo/feature/data/data.dart';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final DatabaseHelper _dbHelper;

  TodoLocalDataSourceImpl(this._dbHelper);

  @override
  Future<void> insertTodo(TodoModel todo) async {
    final db = await _dbHelper.database;
    await db.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<TodoModel?> getTodo(String todoId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('todos', where: 'id = ?', whereArgs: [todoId]);
    if (maps.isEmpty) return null;
    return TodoModel.fromMap(maps.first);
  }

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final db = await _dbHelper.database;
    final maps = await db.query('todos', orderBy: 'created_at DESC');
    return maps.map((map) => TodoModel.fromMap(map)).toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final db = await _dbHelper.database;
    await db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.todoId]);
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    final db = await _dbHelper.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [todoId]);
  }
}
