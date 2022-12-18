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
  int _selectedIndex = 0;
  late List<Widget Function()> _bodyBuilders;

  void stub() async {
    Directory tmp = await getTemporaryDirectory();
    String tmpDir = tmp.path;
    String dbPath = "$tmpDir/Electronic.db";
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);

    DatabaseController dbController = DatabaseController(db);
    await dbController.initialize();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;

    _bodyBuilders = [
      homeTab,
      searchTab,
      userTab
    ];
    stub();
  }

  Widget homeTab() {
    return SingleChildScrollView(
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
    );
  }

  Widget searchTab(){
    return const SingleChildScrollView(
      child: const Text("Search"),
    );
  }

  Widget userTab(){
    return const SingleChildScrollView(
      child: const Text("User"),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = _bodyBuilders[_selectedIndex]();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.supervisor_account_rounded), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index)=>{
          setState((){
            _selectedIndex = index;
          })
        },
      ),
      body: body,
    );
  }
}

