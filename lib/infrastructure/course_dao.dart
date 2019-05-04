import 'package:upg_fisi/infrastructure/dao.dart';
import 'package:upg_fisi/model/course.dart';

class CourseDao implements Dao<Course> {
  final tableName = 'courses';
  final columnId = 'id';
  final _columnName = 'name';
  final _columnDescription = 'description';
  final _columnSemester = 'semester';
  final _columnCredits = 'credits';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnName TEXT,"
    " $_columnDescription TEXT,"
    " $_columnSemester INTEGER,"
    " $_columnCredits INTEGER)";

  @override
  Course fromMap(Map<String, dynamic> query) {
    Course course = Course(query[columnId], query[_columnSemester], query[_columnCredits], query[_columnDescription]);
    return course;
  }

  @override
  Map<String, dynamic> toMap(Course course) {
    return <String, dynamic>{
      _columnName: course.name,
      _columnDescription: course.description,
      _columnSemester: course.semester,
      _columnCredits: course.credits
    };
  }

  Course fromDbRow(dynamic row) {
    return Course.withId(row[columnId], row[_columnName], row[_columnSemester], row[_columnCredits], row[_columnDescription]);
  }

  @override
  List<Course> fromList(result) {
    List<Course> courses = List<Course>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      courses.add(fromDbRow(result[i]));
    }
    return courses;
  }
}
