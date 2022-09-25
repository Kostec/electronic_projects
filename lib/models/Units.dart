import 'package:electronic_projects/models/dbEntity.dart';

enum UnitTypes{
  integer,
  double,
  text
}

// Степени 10
Map<int, String> UnitPrefix = {
  -24: "y", // йокто
  -21: "z", // зепто
  -18: "a", // атто
  -15: "f", // фемто
  -12: "p", // пико
  -9: "n", // нано
  -6: "u", // микро
  -3: "m", //милли
  0: "", // без префикса
  3: "k", // кило
  6: "M", // Мега
  9: "G", // Гига
  12: "T", // Терра
  15: "P", // Пета
  18: "E", // Экса
  21: "Z", // Зетта
};
class Unit implements DbEntity {
  late String name; // Название
  late UnitTypes valueType; // Тип текст или число
  late String? prefix = UnitPrefix[0]; // Степень 10
  late String displayValue; // Как отображается единица измерения

  Unit({required this.name, required this.valueType, required this.displayValue, this.prefix});

  @override
  String toString() {
    return "$prefix$displayValue";
  }

  @override
  int? id;

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      'valueType': valueType.index,
      'prefix': prefix,
      'displayValue': displayValue,
    };
    return map;
  }

  Unit.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    valueType =  UnitTypes.values[map['valueType']];
    prefix = map['prefix'];
    displayValue = map['displayValue'];
  }
}