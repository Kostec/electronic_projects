import 'dart:convert';
import 'dart:typed_data';

import 'package:electronic_projects/models/IDetail.dart';
import 'package:flutter/material.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

import '../models/Project.dart';
import 'ProjectPage.dart';

import 'package:electronic_projects/database/controllers/database.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProjectsPage> createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage> {

  List<Project> projects = [];

  void stub() async {
    var path = myDbModel.databasePath;

    var project1 = Project(
      name: "project1",
      description: "sample project",
    );

    await project1.save();

    var types = await DetailType().select().toList();
    var p = await Project().select().toList();


    var resistor = DetailType(name: "Resistor");
    await resistor.save();
    var transistor = DetailType(name: "Transistor");
    await transistor.save();
    var capacitor = DetailType(name: "Capacitor");
    await capacitor.save();
    var inductive = DetailType(name: "Inductive");
    await inductive.save();
    var battery = DetailType(name: "Battery");
    await battery.save();

    var detail = Detail(name: "KT115");
    // detail.plDetailType = transistor;
    // detail.type = transistor.id;
    detail.values = jsonEncode({
      "values" : [
        {
          "name": "amp coefficient",
          "value": 10,
          "unit": ""
        }
      ]
    });
    await detail.save();

    var r = Detail(name: "Resistor");
    // r.type = resistor.id;
    r.values = jsonEncode({
      "values" : [
        {
          "name": 'resistance',
          "value": 10,
          "unit": "Om"
        },
        {
          "name": 'power',
          "value": 2.5,
          "unit": "Wh"
        }
      ]
    });
    await r.save();

    var project = Project(
      name: "project1",
      description: "sample project",
    );
    project.details = jsonEncode({
        "details":[
          { "id": detail.id, "count": 2, "have": 0},
          { "id": r.id, "count": 10, "have": 0}
        ]});
    await project.save();

    Project().select().toList().then((value) => setState((){ projects = value; }));
  }

  @override
  void initState() {
    stub();
  }

  void _addProject()
  {
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
              // projects.add(IProject(name!, description!));
              Project project = Project(name: name, description: description);
              await project.save();
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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              padding: EdgeInsets.all(5.0),
              child: ListView.separated(
                itemCount: projects.length,
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  var project= projects[index];
                  return ListTile(
                      title: Text(project.name!),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new ProjectPage(project: project))),
                      dense: false,
                    );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
}

