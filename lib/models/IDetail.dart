import 'package:electronic_projects/models/dbEntity.dart';

class IDetailType implements DbEntity {
  late String name;
  late String? icon;

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
      "icon": icon
    };
    return map;
  }

  IDetailType.fromMap(Map map){
    id = map["id"];
    name = map["name"];
    icon = map["icon"];
  }
}

class IDetailParemeter implements DbEntity{
  String name = "";
  String value = "";
  String? unit = "";
  IDetailParemeter({required this.name, required this.value, this.unit});

  @override
  int? id;
  @override
  String get Table => "DetailParameter";

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
    type = map["value"];
    parameters = map["unit"];
    datasheets = map["datasheets"];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "type": type,
      "parameters": parameters,
      "datasheets": datasheets
    };
    return map;
  }
}