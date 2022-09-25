
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/models/Units.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'UnitPage.dart';

class DetailParameterPage extends StatefulWidget {
  final IDetailParemeter? parameter;
  const DetailParameterPage({Key? key, this.parameter}) : super(key: key);

  @override
  State<DetailParameterPage> createState() => DetailParameterPageState();
}

class DetailParameterPageState extends State<DetailParameterPage> {
  late IDetailParemeter _param;

  late String name;
  late String value;
  late Unit? unit;
  late int prefix;
  late String? convention;
  List<DropdownMenuItem<int>> prefixList = [];

  @override
  void initState(){
    if (widget.parameter == null){
      _param = IDetailParemeter(name: "", value: "");
    }
    else {
      _param = widget.parameter!;
    }

    name = _param.name;
    value = _param.value;
    unit = _param?.unit;
    convention = _param.convention;
    prefix = _param.unit != null
        ? UnitPrefix.entries.firstWhere((element) => element.value == _param.unit?.prefix).key
        : 0;

    for (int key in UnitPrefix.keys){
      prefixList.add(DropdownMenuItem<int>(value: key,child: Text(UnitPrefix[key]!)));
    }
  }

  Widget getBody(){
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'Current',
                labelText: 'Parameter name',
              ),
              initialValue: name,
              onChanged: (s) => name = s
          ),
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'I',
                labelText: 'Convention',
              ),
              initialValue: convention,
              onChanged: (s) => convention = s
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: '10',
              labelText: 'Parameter value',
            ),
            initialValue: value,
            onChanged: (s) => value = s,
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
                labelText: 'Unit',
                hintText: "Om"
            ),
            value: unit,
            items: databaseController?.units.list.map((e) => DropdownMenuItem<Unit>(child: Text('${e.name} (${e.displayValue})'), value:  e,)).toList(),
            onChanged: (value){
              setState(() {
                unit = value as Unit;
              });
            },
          ),
          Visibility(
            visible: unit != null,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Prefix',
                  hintText: "K"
              ),
              value: prefix,
              items: prefixList,
              onChanged: (value) {
                prefix = value as int;
              },
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              Unit? unit = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UnitPage()));
              setState(() { });
            },
            child: const Text('New unit'),
          ),
        ],
      ),
    );
  }

  void _accept() {
    _param.name = name;
    _param.value = value;
    _param.unit = unit;
    _param.convention = convention;
    _param.unit?.prefix = UnitPrefix[prefix];
    Navigator.of(context).pop(_param);
    setState(()=>{});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: _accept, icon: const Icon(Icons.save))],
        title: const Text("Detail"),
      ),
      body: getBody(),
    );;
  }
}