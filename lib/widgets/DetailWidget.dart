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
      height: 300,
        child: ListView.separated(
        itemBuilder: (BuildContext context, int idx){
          var parameter = _detail.parameters[idx];
          return ListTile(
            title: Text(parameter.name),
            subtitle: Text('${parameter.value} ${parameter.unit}'),
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
        leading: Icon(Icons.add),
        title: Text(_detail.name),
        subtitle: _expanded ? getParameters() : null,
        trailing: OutlinedButton(
          child: Text('Delete'),
          onPressed: (){
            // TODO action to delete detail
            print('delete');
          }
        ),
        onLongPress: () async {
          // TODO open detail page to edit
          print('edit');
        },
      )
    );
  }
}