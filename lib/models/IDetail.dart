import 'package:electronic_projects/database/controllers/database.dart';

class IDetailType{
  String name;
  String? icon;

  IDetailType.fromName(this.name);


  factory IDetailType(String name){
    IDetailType res = IDetailType.fromName(name);
    return res;
  }
}

class IDetailParemeter{
  String name;
  String value;
  String unit;
  IDetailParemeter(this.name, this.value, this.unit);
}

class IDetail
{
  String name;
  IDetailType type;
  List<IDetailParemeter> parameters;
  List<String>? datasheets = [];

  IDetail(this.name, this.type, this.parameters, {this.datasheets});

  factory IDetail.fromJson(Map<String, dynamic> json){
    return IDetail(json['name'], json['type'], []);
  }
}