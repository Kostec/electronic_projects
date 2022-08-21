import 'dart:convert';

import 'package:electronic_projects/database/models/dbDetail.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';

import '../models/IDetail.dart';
import '../models/Project.dart';
import 'package:electronic_projects/database/controllers/database.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

enum projectPageState {
  main,
  details,
  files
}

class ProjectPageState extends State<ProjectPage> {
  late final Project project;
  Widget body = Container();

  @override
  void initState() {
    project = widget.project;
    body = getMain();
  }

  Widget getDetails()
  {
    return ListView.separated(
        itemCount: (jsonDecode(project.details!) as Map<String, dynamic>).length,
        itemBuilder: (BuildContext context, int i){
          IDetail detail = IDetail.fromJson(jsonDecode(project.details!)[i]);
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
        Text(project.name!),
        Text(project.description!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name!),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue,),
              child: Text(project.name!),
            ),
            ListTile(
              title: Text("Main"),
              onTap: (){/* TODO open details list */
                setState(() {
                  body = getMain();
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Details"),
              onTap: (){/* TODO open details list */
                setState((){
                  body = getDetails();
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Files"),
              onTap: (){/* TODO open details list */
                setState((){
                  body = getDetails();
                });
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: body,
    );
  }
}

