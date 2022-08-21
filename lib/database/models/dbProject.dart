import 'package:sqfentity_gen/sqfentity_gen.dart';

const tableProjects = SqfEntityTable(
    tableName: 'Projects',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "Project",
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('description', DbType.text),
      SqfEntityField("details", DbType.text),
      SqfEntityField('picture', DbType.text, isNotNull: false),
    ]
);