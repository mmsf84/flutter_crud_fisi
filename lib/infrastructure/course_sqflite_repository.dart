import 'package:upg_fisi/infrastructure/course_dao.dart';
import 'package:upg_fisi/infrastructure/course_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/course.dart';

class CourseSqfliteRepository implements CourseRepository {
  final dao = CourseDao();

  @override
  DatabaseProvider databaseProvider;

  CourseSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(Course course) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(course));
    return id;
  }

  @override
  Future<int> delete(Course course) async {
    final db = await databaseProvider.db();
    int result = await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [course.id]);
    return result;
  }

  @override
  Future<int> update(Course course) async {
    final db = await databaseProvider.db();
    int result = await db.update(dao.tableName, dao.toMap(course),
        where: dao.columnId + " = ?", whereArgs: [course.id]);
    return result;
  }

  @override
  Future<List<Course>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM courses order by semester ASC, name ASC");
    return dao.fromList(result);
  }
}