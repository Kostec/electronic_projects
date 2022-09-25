import 'package:electronic_projects/models/Units.dart';
import 'package:electronic_projects/models/dbEntity.dart';

class IDetailParemeter implements DbEntity{
  String name = "";
  String value = "";
  Unit? unit;
  late String? convention; // Условное обозначение
  IDetailParemeter({required this.name, required this.value, this.unit, this.convention});

  @override
  int? id;

  IDetailParemeter.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    value = map["value"];
    convention = map["convention"];
    // if (map.containsKey('unit')) {
    //   unit = Unit.fromMap(map["unit"]);
    // }
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "value": value,
      "unit": unit?.toMap(),
      "convention": convention,
    };
    return map;
  }
}

class IDetailType implements DbEntity {
  late String name;
  late String? icon;
  late String? description;
  late List<IDetailParemeter> parameters = [];

  @override
  int? id;
  @override
  String get Table => "DetailType";

  IDetailType({required this.name, this.icon, this.description});

  @override
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> parametersMap = [];
    for (var item in parameters) {
      parametersMap.add(item.toMap());
    }

    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "icon": icon,
      "description" : description,
      "parameters" : parametersMap
    };
    return map;
  }

  IDetailType.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    icon = map["icon"];
    description = map["description"];

    if (map['parameters'] != null) {
      for (var item in map['parameters'] as List) {
        var param = IDetailParemeter.fromMap(item);
        parameters.add(param);
      }
    }

  }
}

class IDetail implements DbEntity {
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