
import 'package:electronic_projects/models/dbEntity.dart';

const String sqlText = "TEXT";
const String sqlInteger = "INTEGER";

typedef FromMap = DbEntity Function(Map map);

class DbScheme{
  late String tableName;
  late String primaryKey;
  late String primaryKeyType;
  late List<DbField> fields;
  FromMap fromMap;

  DbScheme(this.tableName, this.primaryKey, this.primaryKeyType, this.fields, this.fromMap);

  String createQueue(){
    String queueFields = fields.map((e) => e.create()).join(',');
    String queue = "CREATE TABLE $tableName ($queueFields) PRIMARY KEY ($primaryKey)";
    return queue;
  }
}

class DbField{
  String name;
  String dbType;
  dynamic defaultValue;
  bool isNullable;
  bool isUnique;
  bool isAutoincrement;

  DbField(this.name, this.dbType,
      {this.defaultValue, this.isNullable = false, this.isUnique = false, this.isAutoincrement = false});

  String create(){
    String queue = "${name} ${dbType}";
    if (!isNullable) {
      queue += " NOT NULL";
    }
    if (isUnique){
      queue += " UNIQUE";
    }
    if(defaultValue != null)
    {
      queue += " DEFAULT ";
      if(dbType == sqlText){
        queue += '\'$defaultValue\'';
      }
    }
    if(isAutoincrement){
      queue += " AUTO_INCREMENT";
    }
    return queue;
  }
}