import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upg_fisi/infrastructure/course_dao.dart';
import 'package:upg_fisi/infrastructure/profesor_dao.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  static Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (_db == null) {
      _db = await _init();
    }
    return _db;
  }

  Future<Database> _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'upg_fisinew.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(CourseDao().createTableQuery);
    await db.execute(ProfesorDao().createTableQuery);
  }
}
