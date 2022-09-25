
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/models/Units.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'DetailParameter.dart';
import 'UnitPage.dart';

class DetailTypePage extends StatefulWidget {
  final IDetailType? detailType;
  const DetailTypePage({Key? key, this.detailType}) : super(key: key);

  @override
  State<DetailTypePage> createState() => DetailTypePageState();
}

class DetailTypePageState extends State<DetailTypePage> {
  late IDetailType _detailType;

  late String name;
  late String? icon;
  late String? description;
  late List<IDetailParemeter> parameters = [];

  @override
  void initState(){
    if (widget.detailType == null){
      _detailType = IDetailType(name: "");
    }
    else {
      _detailType = widget.detailType!;
    }

    name = _detailType.name;
    icon = _detailType.icon;
    description = _detailType.description;
    parameters = _detailType.parameters;
  }

  void editParameter(IDetailParemeter param) async {
    var ret = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailParameterPage(parameter: param)));
    if (ret != null){
      param = ret as IDetailParemeter;
    }
    setState(() {});
  }

  Widget getBody() {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'Resistor',
                labelText: 'Detail name',
              ),
              initialValue: name,
              onChanged: (s) => name = s
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Make resistance for current',
              labelText: 'Description',
            ),
            initialValue: description,
            onChanged: (s) => description = s,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: parameters.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = parameters[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("${item.value} ${item.unit.toString()}"),
                    trailing: OutlinedButton(
                        child: Text('Delete'),
                        onPressed: () {
                          setState(() {
                            parameters.remove(item);
                          });
                        }
                    ),
                    onLongPress: (){
                      editParameter(item);
                    },
                    dense: false,
                  );
                }),
          ),
        ],
      ),
    );
  }

  void accept(){
    _detailType.name = name;
    _detailType.description = description;
    _detailType.parameters = parameters;
    _detailType.icon = icon;
    databaseController!.detailTypes.update(_detailType);
    Navigator.of(context).pop(_detailType);
  }

  void addParameter(){
    parameters.add(IDetailParemeter(name: "Parameter", value: "10"));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail type"),
        actions: [IconButton(onPressed: accept, icon: const Icon(Icons.save))],
      ),
      body: SingleChildScrollView(
        child: getBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addParameter,
        tooltip: 'New parameter',
        child: const Icon(Icons.add),)
    );
  }
}