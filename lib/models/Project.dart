import 'IDetail.dart';

class IProject
{
  Map<IDetail, int> _details = {};
  String name = "";
  String description = "";
  List<String> _files = [];

  Map<IDetail, int> get details => _details;
  List<String> get files => _files;

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
