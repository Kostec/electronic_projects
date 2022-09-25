import 'package:electronic_projects/models/dbEntity.dart';
import 'package:sembast/sembast.dart';

class dbEntityContainer <T>{
  final T Function(Map) factory;

  StoreRef store;
  Database db;
  List<T> list = [];

  dbEntityContainer(this.store, this.db, this.factory) {
  }

  Future<void> initialize() async{
    // get all projects from database
    var projs = await store.find(db);
    for(var p in projs){
      var item = await p.ref.get(db);
      T entity = factory(item);
      (entity as DbEntity).id = p.ref.key;
      list.add(entity);
    }
  }

  Future<void> delete(T item) async{
    DbEntity entity = item as DbEntity;
    if (entity.id != null){
      await store.delete(db, finder: Finder(filter: Filter.byKey(entity.id)));
    }
    list.remove(item);
  }

  Future<void> update(T entity) async{
    DbEntity item = entity as DbEntity;

    if(item.id == null){
      int key = await store.add(db, entity.toMap());
      entity.id = key;
      await store.update(db, item.toMap(), finder: Finder(filter: Filter.byKey(key)));
      list.add(entity);
    }
    else{
      await store.update(db, item.toMap(), finder: Finder(filter: Filter.equals('id', item.id)));
    }
  }

  void updateAll() async{
    for(var item in list){
      update(item);
    }
  }

  void clear() async{
    List<T> tmp = [];
    for (var item in list){
      tmp.add(item);
    }
    for (var item in tmp){
      delete(item);
    }
  }

}
