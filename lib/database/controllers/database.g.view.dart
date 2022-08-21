// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SqfEntityFormGenerator
// **************************************************************************

part of 'database.dart';

//ignore: must_be_immutable
class UnitAdd extends StatefulWidget {
  UnitAdd([this._unit]) {
    _unit ??= Unit();
  }
  dynamic _unit;
  @override
  State<StatefulWidget> createState() => UnitAddState(_unit as Unit);
}

class UnitAddState extends State {
  UnitAddState(this.unit);
  Unit unit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtText = TextEditingController();

  @override
  void initState() {
    txtName.text = unit.name == null ? '' : unit.name.toString();
    txtText.text = unit.text == null ? '' : unit.text.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (unit.id == null) ? Text('Add a new unit') : Text('Edit unit'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowText(),
                    saveButton()
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowText() {
    return TextFormField(
      controller: txtText,
      decoration: InputDecoration(labelText: 'Text'),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          save();
        }
      },
      child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void save() async {
    unit
      ..name = txtName.text
      ..text = txtText.text;
    await unit.save();
    if (unit.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(unit.saveResult.toString(),
          title: 'saving Failed!', callBack: () {});
    }
  }
}

//ignore: must_be_immutable
class DetailTypeAdd extends StatefulWidget {
  DetailTypeAdd([this._detailType]) {
    _detailType ??= DetailType();
  }
  dynamic _detailType;
  @override
  State<StatefulWidget> createState() =>
      DetailTypeAddState(_detailType as DetailType);
}

class DetailTypeAddState extends State {
  DetailTypeAddState(this.detailType);
  DetailType detailType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtIcon = TextEditingController();
  final TextEditingController txtLink = TextEditingController();

  @override
  void initState() {
    txtName.text = detailType.name == null ? '' : detailType.name.toString();
    txtIcon.text = detailType.icon == null ? '' : detailType.icon.toString();
    txtLink.text = detailType.link == null ? '' : detailType.link.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (detailType.id == null)
            ? Text('Add a new detailType')
            : Text('Edit detailType'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowIcon(),
                    buildRowLink(),
                    saveButton()
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowIcon() {
    return TextFormField(
      controller: txtIcon,
      decoration: InputDecoration(labelText: 'Icon'),
    );
  }

  Widget buildRowLink() {
    return TextFormField(
      controller: txtLink,
      decoration: InputDecoration(labelText: 'Link'),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          save();
        }
      },
      child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void save() async {
    detailType
      ..name = txtName.text
      ..icon = txtIcon.text
      ..link = txtLink.text;
    await detailType.save();
    if (detailType.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(detailType.saveResult.toString(),
          title: 'saving Failed!', callBack: () {});
    }
  }
}

//ignore: must_be_immutable
class DetailAdd extends StatefulWidget {
  DetailAdd([this._detail]) {
    _detail ??= Detail();
  }
  dynamic _detail;
  @override
  State<StatefulWidget> createState() => DetailAddState(_detail as Detail);
}

class DetailAddState extends State {
  DetailAddState(this.detail);
  Detail detail;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtValues = TextEditingController();

  @override
  void initState() {
    txtName.text = detail.name == null ? '' : detail.name.toString();
    txtValues.text = detail.values == null ? '' : detail.values.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (detail.id == null)
            ? Text('Add a new detail')
            : Text('Edit detail'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowValues(),
                    saveButton()
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowValues() {
    return TextFormField(
      controller: txtValues,
      decoration: InputDecoration(labelText: 'Values'),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          save();
        }
      },
      child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void save() async {
    detail
      ..name = txtName.text
      ..values = txtValues.text;
    await detail.save();
    if (detail.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(detail.saveResult.toString(),
          title: 'saving Failed!', callBack: () {});
    }
  }
}

//ignore: must_be_immutable
class ProjectAdd extends StatefulWidget {
  ProjectAdd([this._project]) {
    _project ??= Project();
  }
  dynamic _project;
  @override
  State<StatefulWidget> createState() => ProjectAddState(_project as Project);
}

class ProjectAddState extends State {
  ProjectAddState(this.project);
  Project project;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDetails = TextEditingController();
  final TextEditingController txtPicture = TextEditingController();

  @override
  void initState() {
    txtName.text = project.name == null ? '' : project.name.toString();
    txtDescription.text =
        project.description == null ? '' : project.description.toString();
    txtDetails.text = project.details == null ? '' : project.details.toString();
    txtPicture.text = project.picture == null ? '' : project.picture.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (project.id == null)
            ? Text('Add a new project')
            : Text('Edit project'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowDescription(),
                    buildRowDetails(),
                    buildRowPicture(),
                    saveButton()
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowDescription() {
    return TextFormField(
      controller: txtDescription,
      decoration: InputDecoration(labelText: 'Description'),
    );
  }

  Widget buildRowDetails() {
    return TextFormField(
      controller: txtDetails,
      decoration: InputDecoration(labelText: 'Details'),
    );
  }

  Widget buildRowPicture() {
    return TextFormField(
      controller: txtPicture,
      decoration: InputDecoration(labelText: 'Picture'),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          save();
        }
      },
      child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void save() async {
    project
      ..name = txtName.text
      ..description = txtDescription.text
      ..details = txtDetails.text
      ..picture = txtPicture.text;
    await project.save();
    if (project.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(project.saveResult.toString(),
          title: 'saving Failed!', callBack: () {});
    }
  }
}
