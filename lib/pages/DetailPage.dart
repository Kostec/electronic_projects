import 'dart:convert';
import 'dart:ffi';

import 'package:electronic_projects/controllers/dbController.dart';
import 'package:flutter/material.dart';

import '../models/IDetail.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  late String name;
  late List<IDetailParemeter> parameters = [];
  late List<String> datasheets = [];
  late IDetailType? type;
  int selectedIndex = 0;

  @override
  void initState() {
    type = databaseController?.detailTypes.list.first;
  }

  void addParameter(){
    // TODO open dialog for params
    parameters.add(IDetailParemeter(name: "Parameter", value: "10"));
    setState(() {});
  }

  void addDatasheet(){
    // TODO open file dialog or write web source
    datasheets.add('Datasheet');
    setState(() {});
  }

  void addDetailType(){
    IDetailType detailType = IDetailType(name: 'DetailType');
    databaseController?.detailTypes.list.add(detailType);
    setState(() {});
  }

  void accept(){
    IDetail detail = IDetail(name: name, type: type!, parameters: parameters);
    Navigator.pop(context, detail);
  }

  Widget getGeneral(){
    return Container(
      height: 600,
      padding: const EdgeInsets.all(5.0),
      child: Expanded(
        child: Column(
          children: [
            OutlinedButton(onPressed: addDetailType, child: Text('NewType')),
            DropdownButtonFormField(
              value: type,
              items: databaseController?.detailTypes.list.map((e) => DropdownMenuItem<IDetailType>(child: Text(e.name), value:  e,)).toList(),
              onChanged: (value){
                type = value as IDetailType;
              }
            ),
            TextFormField(
              decoration: const InputDecoration(
              hintText: 'Resistor 10K',
              labelText: 'name',
              ),
              initialValue: "",
              onChanged: (s) => name = s,
            )
          ]
      )
      )
    );
  }

  Widget getParameter(){
    return Container(
      height: 600,
      padding: const EdgeInsets.all(5.0),
      child: Expanded(
        child: ListView.builder(
          itemCount: parameters.length,
          itemBuilder: (BuildContext context, int index) {
            var item = parameters[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.value),
              trailing: OutlinedButton(
                child: Text('Edit'),
                onPressed: () {
                  setState(() {
                    parameters.remove(item);
                  });
                  }
              ),
              dense: false,
            );
          }),
      ),
    );
  }

  Widget getDatasheets(){
    return Container(
        height: 600,
        padding: const EdgeInsets.all(5.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: datasheets.length,
            itemBuilder: (BuildContext context, int index) {
              var item = datasheets[index];
              return ListTile(
                title: Text(item),
                trailing: OutlinedButton(
                  child: Text('Delete'),
                  onPressed: (){
                    setState(() {
                      datasheets.remove(item);
                    });
                  }
                ),
                dense: false,
              );
            }),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {

    FloatingActionButton? floatingActionButton;

    Widget body = Text('body');
    switch (selectedIndex) {
      case 0:
        body = getGeneral();
        break;
      case 1:
        floatingActionButton = FloatingActionButton(
          onPressed: addParameter, tooltip: 'New parameter', child: const Icon(Icons.add),);
        body = getParameter();
        break;
      case 2:
        floatingActionButton = FloatingActionButton(
          onPressed: addDatasheet, tooltip: 'Add file', child: const Icon(Icons.add),);
        body = getDatasheets();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: accept, icon: const Icon(Icons.add))],
        title: const Text("Detail"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.adb), label: 'General'),
          BottomNavigationBarItem(icon: Icon(Icons.adb), label: 'Parameters'),
          BottomNavigationBarItem(icon: Icon(Icons.adb), label: 'Datasheets'),
        ],
        onTap: (idx){
          selectedIndex = idx;
          setState(() {});
        },
      ),
      body: SingleChildScrollView(
        child: body
      ),
      floatingActionButton: floatingActionButton
    );
  }
}

