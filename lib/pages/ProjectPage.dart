import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';

import '../models/IDetail.dart';
import '../models/Project.dart';
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

  @override
  void initState() {
    project = widget.project;
  }

  Widget getDetails() {
    return ListView.separated(
        itemCount: project.details.length,
        itemBuilder: (BuildContext context, int i){
          IDetail detail = project.details.keys.toList()[i];
          return ListTile(
            onTap: () => print("tapped: ${detail.name}"),
            title: DetailWidget(detail),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget getMain() {
    return Column(
      children: [
        Text(project.name),
        Text(project.description),
      ],
    );
  }

  void addDetail() async{
    IDetail? detail = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage()));
    if (detail == null){
      return;
    }s
    project.details[detail!] = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget body = getBody();
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
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
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: addDetail,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

