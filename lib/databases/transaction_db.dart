import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/transactions.dart';

class TransactionDB {
  String dbName;

  TransactionDB({required this.dbName});
  //เรียกเปิดdatabaseถ้ามีอยู่
  Future<Database> openDB() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocate = join(appDirectory.path, dbName);
    //สร้าง database
    Database database = await databaseFactoryIo.openDatabase(dbLocate);

    return database;
  }

  //เพิ่มข้อมูลเข้าstore
  Future<int> insertDatabase(Transactions statement) async {
    var db = await this.openDB();
    var store = intMapStoreFactory.store('storage');

    var keyID = store.add(db, {
      "name": statement.name,
      "amount": statement.amount,
      "genre": statement.genre,
      "agerec": statement.agerec,
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูลdatabaseมาใช้
  //new to old = false
  //old to new = true
  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDB();
    var store = intMapStoreFactory.store('storage');
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    print(snapshot);
    List<Transactions> transactionlist = [];
    for (var record in snapshot) {
      transactionlist.add(Transactions(
        keyid: record.key,
        name: record["title"].toString(),
        amount: double.parse(record["amount"].toString()),
        genre: record["genre"].toString(),
        agerec: int.parse(record["agerec"].toString()),
      ));
    }
    db.close();
    return transactionlist;
  }

  //ลบข้อมูลในdatabase
  Future<void> deleteDb(int keyid) async {
    var db = await this.openDB();
    var store = intMapStoreFactory.store('storage');
    await store.delete(db,
        finder: Finder(filter: Filter.equals(Field.key, keyid)));
    db.close();
  }

  updateDatabase(Transactions statement) async {
    var db = await this.openDB();
    var store = intMapStoreFactory.store('storage');
    var filter = Finder(filter: Filter.equals(Field.key, statement.keyid));
    var result = store.update(db, finder: filter, {
      "name": statement.name,
      "amount": statement.amount,
      "genre": statement.genre,
      "agerec": statement.agerec,
    });
    db.close();
    print("update result: $result");
  }
}
