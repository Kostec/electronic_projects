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

  @override
  String get Table => "Projects";

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "details": details,
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
