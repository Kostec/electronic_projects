import 'dart:io';
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/pages/AddPages/DetailTypePage.dart';
import 'package:electronic_projects/pages/AddPages/DetailPage.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Project.dart';
import 'AddPages/ProjectPage.dart';

class DetailTypesPage extends StatefulWidget {
  const DetailTypesPage({Key? key}) : super(key: key);

  @override
  State<DetailTypesPage> createState() => DetailTypesPageState();
}

class DetailTypesPageState extends State<DetailTypesPage> {
  String search = "";
  List<IDetailType> viewList = [];

  @override
  void initState() {
    super.initState();
    viewList = databaseController!.detailTypes.list;
  }

  void _addDetailType() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTypePage()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Types"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.update))
        ],
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
                search = s.toLowerCase();
                viewList = databaseController!.detailTypes.list.where((e) => e.name.toLowerCase().contains(search)).toList();
                setState(() { });
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
                    var item = viewList[index];
                    return ListTile(
                      leading: Icon(Icons.adb),
                      title: Text(item.name),
                      trailing: OutlinedButton(
                        onPressed: () async {
                          await databaseController?.detailTypes.delete(item);
                          setState(() {});
                        },
                        child: Text("Delete"),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTypePage(detailType: item)));
                      },
                    );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDetailType,
        tooltip: 'Add project',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

