import 'package:electronic_projects/models/dbEntity.dart';

class IDetailType implements DbEntity {
  late String name;
  late String? icon;
  late String? description;

  @override
  int? id;
  @override
  String get Table => "DetailType";

  IDetailType({required this.name, this.icon});

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "icon": icon,
      "description" : description
    };
    return map;
  }

  IDetailType.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    icon = map["icon"];
    description = map["description"];
  }
}

class IDetailParemeter implements DbEntity{
  String name = "";
  String value = "";
  String? unit = "";
  IDetailParemeter({required this.name, required this.value, this.unit});

  @override
  int? id;

  IDetailParemeter.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    value = map["value"];
    unit = map["unit"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "value": value,
      "unit": unit
    };
    return map;
  }
}

class IDetail implements DbEntity
{
  String name = "Ddetaill";
  IDetailType type = IDetailType(name: "Unknown");
  List<IDetailParemeter> parameters = [];
  List<String>? datasheets = [];
  @override
  int? id;
  @override
  String get Table => "Detail";

  IDetail({required this.name, required this.type, required this.parameters, this.datasheets});

  IDetail.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    type = IDetailType.fromMap(map["type"]);

    if (map["datasheets"] != null){
      for(var ds in map["datasheets"] as List){
        datasheets!.add(ds);
      }
    }
    for (var element in (map["parameters"] as List)) {
      parameters.add(IDetailParemeter.fromMap(element));
    }
  }

  @override
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> parametersMap = [];
    parameters.forEach((value) {
      parametersMap.add(value.toMap());
    });

    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "type": type.toMap(),
      "parameters": parametersMap,
      "datasheets": datasheets
    };
    return map;
  }
}