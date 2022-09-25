import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/models/Project.dart';
import 'package:electronic_projects/pages/DetailsPage.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';

import 'DetailPage.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key, required this.project}) : super(key: key);

  final IProject project;

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

enum projectPageState {
  main,
  details,
  files
}

class ProjectPageState extends State<ProjectPage> {
  late final IProject project;
  late Widget Function() getBody = getMain;
  bool edit = false;

  @override
  void initState() {
    project = widget.project;
  }

  Widget getDetails() {
    return ListView.separated(
      itemCount: project.details.length,
      itemBuilder: (BuildContext context, int i){
        IDetail detail = project.details.keys.toList()[i];
        return DetailWidget(
          detail,
          removeDetail: (d) {
            project.details.remove(d);
            setState(() {});
          }
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget getMain() {
    return Column(
      children: [
        TextFormField(
          enabled: edit,
          decoration: InputDecoration(labelText: 'Project name',hintText: 'Project name'),
          minLines: 1,
          maxLines: 1,
          initialValue: project.name,
        ),
        TextFormField(
          enabled: edit,
          decoration: InputDecoration(labelText: 'Description',hintText: 'Desctription'),
          minLines: 1,
          maxLines: null,
          expands: false,
          initialValue: project.description,
        ),
      ],
    );
  }

  void addDetail() async{
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          selectCallback: (d) async {
            if (project.details.containsKey(d)){
              project.details[d] = project.details[d]! + 1;
            }
            else {
              project.details[d] = 1;
            }
            await databaseController!.projects.update(project);
          },
        )
      )
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget body = getBody();
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(
            onPressed: (){
              edit = !edit;
              setState(() { });
              },
            icon: Icon(Icons.edit))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue,),
              child: Text(project.name),
            ),
            ListTile(
              title: Text("Main"),
              onTap: (){/* TODO open details list */
                setState(() {
                  getBody = getMain;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Details"),
              onTap: (){/* TODO open details list */
                setState((){
                  getBody = getDetails;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Files"),
              onTap: (){/* TODO open file list */
                setState((){
                  getBody = getDetails;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          padding: EdgeInsets.all(5.0),
          child: body
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDetail,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

