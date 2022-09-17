import 'package:sqflite/sqflite.dart';
import '../models/dbEntity.dart';
import 'package:electronic_projects/database/dbScheme.dart';

class DatabaseController{
  static late Database db;
  late String dbPath;
  Map<String, DbScheme> schemes = {};

  DatabaseController(List<DbScheme> schemes){
    for(var s in schemes){
      this.schemes[s.tableName] = s;
    }
  }

  void open(String dbPath) async {
    db = await openDatabase(dbPath,
      onCreate: (Database db, int version) async {
        for (var element in schemes.values) {
          await db.execute(element.createQueue());
        }
      }
    );
    if(!db.isOpen){
      throw "Db not opened";
    }

  }

  void close() async {
    db.close();
  }

  Future<DbEntity> addEntity(DbEntity entity) async {
    entity.id = await db.insert(entity.Table, entity.toMap());
    return entity;
  }

  Future<DbEntity?> getEntity(String table, int id) async{
    List<Map> maps = await db.query(table, where: 'Id = ?', whereArgs: [id]);
    if(maps.isNotEmpty){
      Map map = maps.first;
      return schemes[table]?.fromMap(map);
    }
    return null;
  }
}