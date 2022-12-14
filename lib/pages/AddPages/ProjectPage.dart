import 'dart:io';

import 'package:electronic_projects/controllers/dbController.dart';
import 'package:electronic_projects/models/IDetail.dart';
import 'package:electronic_projects/models/Project.dart';
import 'package:electronic_projects/pages/DetailsPage.dart';
import 'package:electronic_projects/widgets/DetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_filex/open_filex.dart';

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
  late void Function() addAction;
  bool edit = false;

  @override
  void initState() {
    project = widget.project;
    addAction = addDetail;
  }

  Widget getFiles() {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: project.files.length,
      itemBuilder: (BuildContext context, int i){
        String file = project.files[i];
        String name = p.basename(file);
        String ext = p.extension(file).toUpperCase();
        return ListTile(
          title: Text(name),
          subtitle: Text(ext),
          onTap: () async{
            File f = File(file);
            if (await f.exists()) {
              OpenFilex.open(file);
            }
          },
          trailing: OutlinedButton(
              child: Text('Delete'),
              onPressed: () async {
                String projectsPath = "/storage/emulated/0/ElectronicProjects/Projects";
                Directory projectDir = Directory(p.join(projectsPath, '${project.name}_${project.id}'));
                PermissionStatus status = await Permission.storage.request();
                if (status.isDenied) {
                  /* TODO error */
                  return;
                }
                else {
                  File f = File(file);
                  if ((await f.exists())) {
                    await f.delete();
                  }
                }
                project.files.remove(file);
                await databaseController?.projects.update(project);
                setState(() { });
              }
          ),
        );
      },
    );
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

  void addFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      Directory tmp = await getTemporaryDirectory();
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String tmpDir = p.join(appDocDir.path, '${project.name}_${project.id}');

      String projectsPath = "/storage/emulated/0/ElectronicProjects/Projects";
      Directory projectDir = Directory(p.join(projectsPath, '${project.name}_${project.id}'));
      if (!(await projectDir.exists())) {
        PermissionStatus status = await Permission.storage.request();
        if (status.isDenied) {
          /* TODO error */
          return;
        }
        projectDir = await projectDir.create(recursive: true);
      }

      for (var f in files) {
        String newPath = p.join(projectDir.path, p.basename(f.path));
        File newFile = await f.copy(newPath);
        print(newFile.path);
        project.files.add(newFile.path);
      }

      await databaseController?.projects.update(project);
      setState(() { });

    } else {
      // User canceled the picker
    }
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
                  addAction = addDetail;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Files"),
              onTap: (){/* TODO open file list */
                setState((){
                  getBody = getFiles;
                  addAction = addFile;
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
        onPressed: addAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

