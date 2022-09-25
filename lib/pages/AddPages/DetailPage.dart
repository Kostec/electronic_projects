import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/pages/AddPages/DetailParameter.dart';
import 'package:electronic_projects/pages/AddPages/DetailTypePage.dart';
import 'package:flutter/material.dart';

import '../../models/IDetail.dart';

class DetailPage extends StatefulWidget {
  final IDetail? detail;
  const DetailPage({Key? key, this.detail}) : super(key: key);

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  late IDetail _detail;

  late String name = "";
  late List<IDetailParemeter> parameters = [];
  late List<IDetailParemeter> recParams = [];
  late List<IDetailParemeter> allParams = [];
  late List<String> datasheets = [];
  late IDetailType? type;
  int selectedIndex = 0;

  @override
  void initState() {
    type = databaseController?.detailTypes.list.first;
    if (widget.detail != null) {
        name = widget.detail!.name;
        parameters = widget.detail!.parameters;
        datasheets = widget.detail!.datasheets != null ? widget.detail!.datasheets! : [];
        type = widget.detail!.type;
        _detail = widget.detail!;
    }
    else {
      _detail = IDetail(name: name, type: type!, parameters: parameters);
    }
    checkRecommendedParams();
  }

  void addParameter(){
    IDetailParemeter detailParemeter = IDetailParemeter(name: "Parameter", value: "10");
    parameters.add(detailParemeter);
    allParams.add(detailParemeter);
    setState(() {});
  }

  void addDatasheet(){
    // TODO open file dialog or write web source
    datasheets.add('Datasheet');
    setState(() {});
  }

  void addDetailType() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTypePage()));
    setState(() {});
  }

  void accept() async {
    _detail!.name = name;
    _detail!.parameters = allParams;
    _detail!.datasheets = datasheets;
    _detail!.type = type!;
    await databaseController!.details.update(_detail!);
    Navigator.pop(context, _detail);
  }

  void checkRecommendedParams(){
    recParams.clear();
    recParams.addAll(type!.parameters!);
    for (var p in parameters){
      recParams.removeWhere((e) => (e.name == p.name) && (e.id == p.id));
    }
    allParams.clear();
    allParams.addAll(recParams);
    allParams.addAll(parameters);
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
              items: databaseController?.detailTypes.list.map((e) => DropdownMenuItem<IDetailType>(child: Text(e.name), value:  e)).toList(),
              onChanged: (value){
                type = value as IDetailType;
                checkRecommendedParams();
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
              hintText: 'Resistor 10K',
              labelText: 'name',
              ),
              initialValue: name,
              onChanged: (s) => name = s,
            )
          ]
      )
      )
    );
  }

  void editParameter(IDetailParemeter param) async {
    var ret = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailParameterPage(parameter: param)));
    if (ret != null){
      param = ret as IDetailParemeter;
    }
    setState(() {});
  }
  
  Widget parametersList(List<IDetailParemeter> list){
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        var item = list[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text("${item.value} ${item.unit.toString()}"),
          trailing: OutlinedButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  list.remove(item);
                });
              }
          ),
          onLongPress: (){
            editParameter(item);
          },
          dense: false,
        );
      },
    );
  }

  Widget getParameter(){
    return Container(
      height: 600,
      padding: const EdgeInsets.all(5.0),
      child: Expanded(
        child: parametersList(allParams)),
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
        actions: [IconButton(onPressed: accept, icon: const Icon(Icons.save))],
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

