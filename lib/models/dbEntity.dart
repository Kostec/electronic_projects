import 'package:flutter/foundation.dart';

class DbEntity{
  int? id;
  DbEntity({this.id});

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
