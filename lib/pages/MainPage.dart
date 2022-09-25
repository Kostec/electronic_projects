import 'dart:io';
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/pages/DetailTypesPage.dart';
import 'package:electronic_projects/pages/DetailsPage.dart';
import 'package:electronic_projects/pages/ProjectsPage.dart';
import 'package:electronic_projects/pages/UnitsPage.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Project.dart';
import 'AddPages/ProjectPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  void stub() async {
    Directory tmp = await getTemporaryDirectory();
    String tmpDir = tmp.path;
    String dbPath = "$tmpDir/Electronic.db";
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);

    DatabaseController dbController = DatabaseController(db);
    await dbController.initialize();

    // dbController.units.clear();
    // dbController.projects.clear();
    // dbController.details.clear();
    // dbController.detailTypes.clear();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    stub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.all(5.0),
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text("Projects"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProjectsPage())),
            ),
            ListTile(
              title: Text("Details"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailsPage())),
            ),
            ListTile(
              title: Text("Types"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailTypesPage())),
            ),
            ListTile(
              title: Text("Units"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UnitsPage())),
            ),
          ],
        ),
      ),
    );
  }
}

