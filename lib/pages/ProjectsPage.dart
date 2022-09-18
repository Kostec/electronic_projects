import 'dart:io';
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Project.dart';
import 'ProjectPage.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProjectsPage> createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage> {
  void stub() async {
    Directory tmp = await getTemporaryDirectory();
    String tmpDir = tmp.path;
    String dbPath = "$tmpDir/Electronic.db";
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);

    DatabaseController dbController = DatabaseController(db);
    await dbController.initialize();

    dbController.detailTypes.list.add(IDetailType(name: 'Reistor'));
    dbController.detailTypes.list.add(IDetailType(name: 'Capaitor'));
    dbController.detailTypes.list.add(IDetailType(name: 'Inductor'));
    dbController.detailTypes.list.add(IDetailType(name: 'Wire'));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    stub();
  }

  void _addProject() {
    String? name = "";
    String? description = "";

    showDialog(
      context: context,
        builder: (ctx) => SimpleDialog(
          title: Text("New Project"),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Marshall',
                labelText: 'Project name',
              ),
              initialValue: "",
              onChanged: (s) => name = s
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Guitar apmfilter',
                labelText: 'Project description',
              ),
              initialValue: "",
              onChanged: (s) => description = s,
            ),
            OutlinedButton(onPressed: () async {
              var newProject = IProject(name!, description!);
              databaseController?.projects.list.add(newProject);
              databaseController?.projects.update(newProject);
              setState(()=>{});
              Navigator.of(context).pop();
            }, child: Text("Create")),
            OutlinedButton(onPressed: () => { Navigator.of(context).pop() }, child: Text("Cancel")),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 600,
              padding: const EdgeInsets.all(5.0),
              child:
              Expanded(
                child: ListView.separated(
                  itemCount: databaseController == null ? 0 : databaseController!.projects.list.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    var project= databaseController!.projects.list[index];
                    return ListTile(
                        title: Text(project.name),
                        trailing: OutlinedButton(
                          child: Text('delete'),
                          onPressed: (){
                            databaseController?.projects.list.remove(project);
                            databaseController?.projects.update(project);
                            setState(() {});
                          },
                        ),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new ProjectPage(project: project))),
                        dense: false,
                      );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        tooltip: 'Add project',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

