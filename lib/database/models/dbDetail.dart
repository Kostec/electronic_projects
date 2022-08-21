import 'package:sqfentity_gen/sqfentity_gen.dart';

const tableUnits = SqfEntityTable(
    tableName: 'Units',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: 'Unit',
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('text', DbType.text),
    ]
);

const tableDetailType = SqfEntityTable(
    tableName: 'DetailTypes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "DetailType",
    fields: [
      SqfEntityField('name', DbType.text, isNotNull: true),
      SqfEntityField('icon', DbType.text, isNotNull: false),
      SqfEntityField('link', DbType.text, isNotNull: false),
    ]
);

const tableDetail = SqfEntityTable(
    tableName: 'Details',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: "Detail",
    fields: [
      SqfEntityField('name', DbType.text, isNotNull: true, isUnique: true),
      // SqfEntityFieldRelationship(
      //   fieldName: "type",
      //   parentTable: tableDetailType,
      //   deleteRule: DeleteRule.NO_ACTION,
      //   relationType: RelationType.ONE_TO_MANY,
      //   formDropDownTextField: 'name',
      //   isNotNull: true
      // ),
      SqfEntityField('values', DbType.text)
    ]
);