import 'dbEntity.dart';
import 'IDetail.dart';

class IProject implements DbEntity
{
  String name = "";
  String description = "";
  Map<IDetail, int> _details = {};
  List<String> _files = [];

  Map<IDetail, int> get details => _details;
  List<String> get files => _files;

  @override
  int? id;

  IProject.fromMap(Map map){
    if (map['details'] != null) {
      for (var d in map['details'] as List) {
        var detail = IDetail.fromMap(d);
        if (details.containsKey(detail)) {
          details[detail] = details[detail]! + 1;
        }
        else {
          details[detail] = 1;
        }
      }
    }

    id = map['id'];
    name = map['name'];
    description = map['description'];
    if(map['files'] != null) {
      for (var f in map['files'] as List) {
        _files.add(f);
      }
    }
  }

  @override
  Map<String, dynamic> toMap() {

    List<Map<String, dynamic>> detailsMap = [];
    details.forEach((key, value) {
      detailsMap.add(key.toMap());
    });

    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "details": detailsMap,
      "files": files
    };
    return map;
  }

  IProject(this.name, this.description);

  void setName(String name) => this.name = name;
  void setDescription(String description) => this.description = description;

  void addDetail(IDetail detail, {int count = 1})
  {
    assert(count > 0);
    _details[detail] = count;
  }

  void removeDetail(IDetail detail, {int count = 1}){
    if (_details.containsKey(detail)){
      _details.remove(detail);
    }
  }

  void addFile(String filename)
  {
    _files.add(filename);
  }


}
