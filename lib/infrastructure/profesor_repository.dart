import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/profesor.dart';

abstract class ProfesorRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(Profesor profesor);
  Future<int> update(Profesor profesor);
  Future<int> delete(Profesor profesor);
  Future<List<Profesor>> getList();
}