import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/dbEntity.dart';

class dbEntityList implements List<DbEntity>{
  late Database db;

  List<DbEntity> list = [];

  @override
  late DbEntity first;
  @override
  late DbEntity last;
  @override
  late int length;

  dbEntityList(this.db){
    if(!db.isOpen){
      throw Exception("Database is not opened");
    }
    first = list.first;
    last = list.last;
    length = list.length;
  }

  void update(DbEntity entity){

  }

  void updateAll(){

  }



  @override
  void add(DbEntity value) {
    list.add(value);
  }

  @override
  void addAll(Iterable<DbEntity> iterable) {
    list.addAll(iterable);
  }

  @override
  List<DbEntity> operator +(List<DbEntity> other) {
    return list + other;
  }

  @override
  void insert(int index, DbEntity element) {
    list.insert(index, element);
  }

  @override
  void insertAll(int index, Iterable<DbEntity> iterable) {
    list.insertAll(index, iterable);
  }

  @override
  bool remove(Object? value) {
    return list.remove(value);
  }

  @override
  DbEntity removeAt(int index) {
    return list.removeAt(index);
  }

  @override
  DbEntity removeLast() {
    return list.removeLast();
  }

  @override
  void removeRange(int start, int end) {
    list.removeRange(start, end);
  }

  @override
  void removeWhere(bool Function(DbEntity element) test) {
    list.removeWhere(test);
  }

  @override
  void clear() {
    list.clear();
  }

  @override
  DbEntity operator [](int index) => list[index];

  @override
  void operator []=(int index, DbEntity value) => list[index] = value;

  @override
  bool any(bool Function(DbEntity element) test) => list.any(test);

  @override
  Map<int, DbEntity> asMap() => list.asMap();

  @override
  List<R> cast<R>() => list.cast<R>();

  @override
  bool contains(Object? element) => list.contains(element);

  @override
  DbEntity elementAt(int index) => list.elementAt(index);

  @override
  bool every(bool Function(DbEntity element) test) => list.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(DbEntity element) toElements) => list.expand(toElements);

  @override
  void fillRange(int start, int end, [DbEntity? fillValue]) => list.fillRange(start, end, fillValue);

  @override
  DbEntity firstWhere(bool Function(DbEntity element) test, {DbEntity Function()? orElse}) => list.firstWhere(test);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, DbEntity element) combine) => list.fold(initialValue, combine);

  @override
  Iterable<DbEntity> followedBy(Iterable<DbEntity> other) => list.followedBy(other);

  @override
  void forEach(void Function(DbEntity element) action) => list.forEach(action);

  @override
  Iterable<DbEntity> getRange(int start, int end) => list.getRange(start, end);

  @override
  int indexOf(DbEntity element, [int start = 0]) => list.indexOf(element, start);

  @override
  int indexWhere(bool Function(DbEntity element) test, [int start = 0]) => indexWhere(test, start);

  @override
  bool get isEmpty => list.isEmpty;

  @override
  bool get isNotEmpty => list.isNotEmpty;

  @override
  Iterator<DbEntity> get iterator => list.iterator;

  @override
  String join([String separator = ""]) => list.join(separator);

  @override
  int lastIndexOf(DbEntity element, [int? start]) => lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(DbEntity element) test, [int? start]) => lastIndexWhere(test, start);

  @override
  DbEntity lastWhere(bool Function(DbEntity element) test, {DbEntity Function()? orElse}) => list.lastWhere(test, orElse : orElse);

  @override
  Iterable<T> map<T>(T Function(DbEntity e) toElement) => list.map(toElement);

  @override
  DbEntity reduce(DbEntity Function(DbEntity value, DbEntity element) combine) => list.reduce(combine);

  @override
  void replaceRange(int start, int end, Iterable<DbEntity> replacements) {
    list.replaceRange(start, end, replacements);
  }

  @override
  void retainWhere(bool Function(DbEntity element) test) {
    list.retainWhere(test);
  }

  @override
  Iterable<DbEntity> get reversed => list.reversed;

  @override
  void setAll(int index, Iterable<DbEntity> iterable) {
    list.setAll(index, iterable);
  }

  @override
  void setRange(int start, int end, Iterable<DbEntity> iterable, [int skipCount = 0]) {
    list.setRange(start, end, iterable, skipCount);
  }

  @override
  void shuffle([Random? random]) {
    list.shuffle(random);
  }

  @override
  DbEntity get single => list.single;

  @override
  DbEntity singleWhere(bool Function(DbEntity element) test, {DbEntity Function()? orElse}) {
    return list.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<DbEntity> skip(int count) => list.skip(count);

  @override
  Iterable<DbEntity> skipWhile(bool Function(DbEntity value) test) => list.where(test);

  @override
  void sort([int Function(DbEntity a, DbEntity b)? compare]) => list.sort(compare);

  @override
  List<DbEntity> sublist(int start, [int? end]) => list.sublist(start, end);

  @override
  Iterable<DbEntity> take(int count) => list.take(count);

  @override
  Iterable<DbEntity> takeWhile(bool Function(DbEntity value) test) => list.takeWhile(test);

  @override
  List<DbEntity> toList({bool growable = true}) => list.toList(growable: growable);

  @override
  Set<DbEntity> toSet() => list.toSet();

  @override
  Iterable<DbEntity> where(bool Function(DbEntity element) test) => list.where(test);

  @override
  Iterable<T> whereType<T>() => list.whereType<T>();
}
