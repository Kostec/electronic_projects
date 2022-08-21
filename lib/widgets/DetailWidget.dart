import 'package:electronic_projects/models/IDetail.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget{
  IDetail detail;
  DetailWidget(this.detail, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailWidgetState();
}

class DetailWidgetState extends State<DetailWidget>{
  late final IDetail _detail;
  bool _expanded = false;
  @override
  void initState() {
    _detail = widget.detail;
  }

  Widget getParameters(){
    return Container(
      // width: 300,
      height: 300,
        child: ListView.separated(
        itemBuilder: (BuildContext context, int idx){
          var parameter = _detail.parameters[idx];
          return Row(
              children: [
                Text("${parameter.name}: ${parameter.value} ${parameter.unit}"),
              ]
          );
        },
        separatorBuilder: (BuildContext context, int idx) => const Divider(),
        itemCount: _detail.parameters.length)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => setState(() {_expanded = !_expanded;}),
        title: Column(
          children: [
            Row(
              children: [
                // if (_detail.type.icon == null) Text(_detail.type.name) else const Icon(Icons.add),
                Icon(Icons.add),
                Text(_detail.name),
              ],
            ),
            _expanded ? getParameters() : Container()
          ],
        )
      ),
    );
  }
}