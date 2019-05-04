import 'package:upg_fisi/infrastructure/dao.dart';
import 'package:upg_fisi/model/profesor.dart';

class ProfesorDao implements Dao<Profesor> {
  final tableName = 'profesors';
  final columnId = 'id';
  final _columnName = 'name';
  final _columnLastname = 'lastname';
  final _columnNivel = 'nivel';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnName TEXT,"
    " $_columnLastname TEXT,"
    " $_columnNivel INTEGER)";

  @override
  Profesor fromMap(Map<String, dynamic> query) {
    Profesor profesor = Profesor(query[_columnName], query[_columnLastname], query[_columnNivel]);
    return profesor;
  }

  @override
  Map<String, dynamic> toMap(Profesor profesor) {
    return <String, dynamic>{
      _columnName: profesor.name,
      _columnLastname: profesor.lastname,
      _columnNivel: profesor.nivel
    };
  }

  Profesor fromDbRow(dynamic row) {
    return Profesor.withId(row[columnId], row[_columnName], row[_columnLastname], row[_columnNivel]);
  }

  @override
  List<Profesor> fromList(result) {
    List<Profesor> profesores = List<Profesor>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      profesores.add(fromDbRow(result[i]));
    }
    return profesores;
  }
}
