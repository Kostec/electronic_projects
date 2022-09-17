import 'package:electronic_projects/database/dbScheme.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:flutter/material.dart';

import '../models/Project.dart';
import 'ProjectPage.dart';
import '../controllers/dbController.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ProjectsPage> createState() => ProjectsPageState();
}

class ProjectsPageState extends State<ProjectsPage> {

  List<IProject> projects = [];
  late DatabaseController db;

  void stub() async {
    
    var d = IDetailType(name: "resistor");
    d.toMap();

    IProject project = IProject("project1", "my first project");
    project.addDetail(IDetail(
      name: "Detail1",
      type: IDetailType(name: "resistor"),
      parameters:[
        IDetailParemeter(name: "Resistance", value: "10", unit: "Om"),
        IDetailParemeter(name: "Max power", value: "2.5", unit: "Wh"),
      ],
      datasheets: []
    )
    );
    projects.add(project);
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
              setState(()=>{projects.add(IProject(name!, description!))});
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
                      title: Text(project.name),
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

