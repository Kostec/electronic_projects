import 'dart:io';
import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Project.dart';
import 'AddPages/ProjectPage.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();
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
              await databaseController?.projects.update(newProject);
              setState(()=>{});
              Navigator.of(context).pop();
            }, child: Text("Create")),
            OutlinedButton(onPressed: () => { Navigator.of(context).pop() }, child: Text("Cancel")),
          ],
        )
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projects"),
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
                          onPressed: () async {
                            await databaseController?.projects.delete(project);
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

