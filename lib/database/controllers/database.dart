import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

import '../tools/helper.dart';
import 'view.list.dart';

import '../models/dbDetail.dart';
import '../models/dbProject.dart';

import 'dart:typed_data';

part 'database.g.view.dart';
part 'database.g.dart';

// run flutter pub run build_runner build --delete-conflicting-outputs
// check database.g files

const seqIdentity = SqfEntitySequence(sequenceName: 'identity');

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel',
    databaseName: 'MyDb1.db',
    password: null, // You can set a password if you want to use crypted database (For more information: https://github.com/sqlcipher/sqlcipher)
    // put defined tables into the tables list.
    databaseTables: [tableUnits, tableDetailType, tableDetail, tableProjects],
    // You can define tables to generate add/edit view forms if you want to use Form Generator property
    formTables: [tableUnits, tableDetailType, tableDetail, tableProjects],
    // put defined sequences into the sequences list.
    sequences: [seqIdentity],
    dbVersion: 3,
    // This value is optional. When bundledDatabasePath is empty then
    // EntityBase creats a new database when initializing the database
    bundledDatabasePath: null, //         'assets/sample.db'
    // This value is optional. When databasePath is null then
    // EntityBase uses the default path from sqflite.getDatabasesPath()
    // databasePath: '/storage/emulated/0/Download/Volumes/Repo/MyProject/db',
    defaultColumns: [
      // SqfEntityField('dateCreated', DbType.datetime, defaultValue: 'DateTime.now()'),
    ]);