import '../models/IDetail.dart';
import '../models/Project.dart';
import 'dbEntityList.dart';
import 'package:sembast/sembast.dart';

DatabaseController? databaseController;

class DatabaseController{
  late Database db;
  late dbEntityContainer<IProject> projects;
  late dbEntityContainer<IDetailType> detailTypes;

  DatabaseController(this.db){
    if (databaseController == null) {
      var store = intMapStoreFactory.store('Projects');
      projects = dbEntityContainer(store, db, IProject.fromMap);
      store = intMapStoreFactory.store('DetailTypes');
      detailTypes = dbEntityContainer(store, db, IDetailType.fromMap);
    }
    databaseController = this;
  }

  Future<void> initialize() async{
    await projects.initialize();
    await detailTypes.initialize();
  }
}