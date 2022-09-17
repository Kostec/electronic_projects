import 'package:electronic_projects/database/dbScheme.dart';
import 'package:flutter/foundation.dart';

class DbEntity{
  int? id;
  DbEntity({this.id});

  @protected
  String get Table => "Entity";

  DbEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
  }

  @protected
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}
