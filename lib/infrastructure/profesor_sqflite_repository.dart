import 'package:upg_fisi/infrastructure/profesor_dao.dart';
import 'package:upg_fisi/infrastructure/profesor_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/profesor.dart';

class ProfesorSqfliteRepository implements ProfesorRepository {
  final dao = ProfesorDao();

  @override
  DatabaseProvider databaseProvider;

  ProfesorSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(Profesor profesor) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(profesor));
    return id;
  }

  @override
  Future<int> delete(Profesor profesor) async {
    final db = await databaseProvider.db();
    int result = await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [profesor.id]);
    return result;
  }

  @override
  Future<int> update(Profesor profesor) async {
    final db = await databaseProvider.db();
    int result = await db.update(dao.tableName, dao.toMap(profesor),
        where: dao.columnId + " = ?", whereArgs: [profesor.id]);
    return result;
  }

  @override
  Future<List<Profesor>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM profesors order by lastname ASC");
    return dao.fromList(result);
  }
}