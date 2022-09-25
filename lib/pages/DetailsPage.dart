import 'dart:io';
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/pages/AddPages/DetailPage.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Project.dart';
import 'AddPages/ProjectPage.dart';

class DetailsPage extends StatefulWidget {
  final void Function(IDetail detail)? selectCallback;
  const DetailsPage({Key? key, this.selectCallback}) : super(key: key);

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  String search = "";
  List<IDetail> viewList = [];

  @override
  void initState() {
    super.initState();
    viewList = databaseController!.details.list;
  }

  void _addDetail() async {
    IDetail? detail = await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
    if(detail != null){
      viewList = databaseController!.details.list;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Search",
                ),
                initialValue: "",
                onChanged: (s){
                  search = s;
                  viewList = databaseController!.details.list.where((e) => e.name.contains(search)).toList();
                },),
                Container(
                  height: 600,
                  padding: const EdgeInsets.all(5.0),
                  child:
                    Expanded(
                      child: ListView.separated(
                        itemCount: viewList.length,
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          var detail = viewList[index];
                          return DetailWidget(
                            detail,
                            selectCallback: widget.selectCallback,
                            removeDetail: (detail) async {
                              await databaseController?.details.delete(detail);
                              setState((){});
                            }
                          );
                        }
                      ),
                    ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDetail,
        tooltip: 'Add project',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

