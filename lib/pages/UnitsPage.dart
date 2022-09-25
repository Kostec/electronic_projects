import 'dart:io';
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/models/Units.dart';
import 'package:electronic_projects/pages/AddPages/DetailTypePage.dart';
import 'package:electronic_projects/pages/AddPages/UnitPage.dart';
import 'package:electronic_projects/pages/AddPages/DetailPage.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Project.dart';
import 'AddPages/ProjectPage.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({Key? key}) : super(key: key);

  @override
  State<UnitsPage> createState() => UnitsPageState();
}

class UnitsPageState extends State<UnitsPage> {
  String search = "";
  List<Unit> viewList = [];

  @override
  void initState() {
    super.initState();
    viewList = databaseController!.units.list;
  }

  void _addUnit() async {
    var ret = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnitPage()));
    setState(() {});
    viewList = databaseController!.units.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Units"),
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
                viewList = databaseController!.units.list.where((e) => e.name.toLowerCase().contains(search)).toList();
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
                          await databaseController?.units.delete(item);
                          setState(() {});
                        },
                        child: Text("Delete"),
                      ),
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnitPage(unit: item)));
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
        onPressed: _addUnit,
        tooltip: 'Add project',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

