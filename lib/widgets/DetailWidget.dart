import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/pages/AddPages/DetailPage.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget{
  IDetail detail;
  final void Function(IDetail detail)? removeDetail;
  final Future<void> Function(IDetail detail)? selectCallback;
  DetailWidget(this.detail, {this.removeDetail, this.selectCallback, Key? key}) : super(key: key);

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
    return ListTile(
      onTap: () async {
        await widget.selectCallback!(_detail);
        Navigator.of(context).pop(_detail);
      },
      title: Text(_detail.name),
      trailing: widget.removeDetail == null ? null : OutlinedButton(
        child: Text('Delete'),
        onPressed: () => widget.removeDetail!(_detail)
      ),
      onLongPress: () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(detail: _detail,)));
      },
    );
  }
}