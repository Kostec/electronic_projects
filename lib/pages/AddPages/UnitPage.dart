import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/Units.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UnitPage extends StatefulWidget {
  Unit? unit;
  UnitPage({this.unit, Key? key}) : super(key: key);

  @override
  State<UnitPage> createState() => UnitPageState();
}

class UnitPageState extends State<UnitPage> {
  Unit? _unit;

  late String? name; // Название
  late UnitTypes? type; // Число или текст
  late String? displayValue; // Как отображается единица измерения

  @override
  void initState(){
    if (widget.unit == null){
      _unit = Unit(name : "", valueType: UnitTypes.text, displayValue: "");
    }
    else {
      _unit = widget.unit!;
    }

    name = _unit?.name;
    type = _unit?.valueType;
    displayValue = _unit?.displayValue;
  }

  Widget getBody(){
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'Resistance',
                labelText: 'Unit name',
              ),
              initialValue: name,
              onChanged: (s) => name = s
          ),
          DropdownButtonFormField(
            value: type,
            items: UnitTypes.values.map((e) => DropdownMenuItem<UnitTypes>(child: Text(e.toString()), value:  e,)).toList(),
            onChanged: (value){
              type = value as UnitTypes;
            },
          ),
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'Om',
                labelText: 'Display value',
              ),
              initialValue: displayValue,
              onChanged: (s) => displayValue = s
          ),
          OutlinedButton(
            onPressed: accept,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void accept() async {
    _unit?.name = name!;
    _unit?.valueType = type!;
    _unit?.displayValue = displayValue!;
    widget.unit = _unit;
    await databaseController!.units.update(_unit!);
    Navigator.of(context).pop(_unit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: accept, icon: const Icon(Icons.save))],
        title: const Text("Detail"),
      ),
      body: getBody(),
    );
  }
}
