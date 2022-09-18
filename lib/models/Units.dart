import 'package:electronic_projects/models/dbEntity.dart';

enum UnitTypes{
  integer,
  double,
  test
}

// Степени 10
Map<int, String> UnitPrefix = {
  {-24, "y"}, // йокто
  {-21, "z"}, // зепто
  {-18, "a"}, // атто
  {-15, "f"}, // фемто
  {-12, "p"}, // пико
  {-9, "n"}, // нано
  {-6, "u"}, // микро
  {-3, "m"}, //милли
  {0, ""}, // без префикса
  {3, "k"}, // кило
  {6, "M"}, // Мега
  {9, "G"}, // Гига
  {12, "T"}, // Терра
  {15, "P"}, // Пета
  {18, "E"}, // Экса
  {21, "Z"}, // Зетта
} as Map<int, String>;

class Units implements DbEntity {
  late String name;
  late UnitTypes valueType;
  late String prefix;
  late String displayValue;

  @override
  String toString() {
    return "$prefix$displayValue";
  }

  @override
  int? id;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}