import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/course.dart';

abstract class CourseRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(Course course);
  Future<int> update(Course course);
  Future<int> delete(Course course);
  Future<List<Course>> getList();
}