import 'package:electronic_projects/models/Units.dart';

import '../models/IDetail.dart';
import '../models/Project.dart';
import 'dbEntityList.dart';
import 'package:sembast/sembast.dart';

DatabaseController? databaseController;

class DatabaseController{
  late Database db;
  late dbEntityContainer<IProject> projects;
  late dbEntityContainer<IDetail> details;
  late dbEntityContainer<IDetailType> detailTypes;
  late dbEntityContainer<Unit> units;

  DatabaseController(this.db){
    if (databaseController == null) {
      var store = intMapStoreFactory.store('Projects');
      projects = dbEntityContainer(store, db, IProject.fromMap);
      store = intMapStoreFactory.store('DetailTypes');
      detailTypes = dbEntityContainer(store, db, IDetailType.fromMap);
      store = intMapStoreFactory.store('Units');
      units = dbEntityContainer(store, db, Unit.fromMap);
      store = intMapStoreFactory.store('Details');
      details = dbEntityContainer(store, db, IDetail.fromMap);
    }
    databaseController = this;
  }

  Future<void> initialize() async{
    await projects.initialize();
    await detailTypes.initialize();
    await units.initialize();
    await details.initialize();
  }
}