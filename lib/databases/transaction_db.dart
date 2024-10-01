import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/transactions.dart';


class TransactionDB{
  String dbName;


  TransactionDB({required this.dbName});
  //เรียกเปิดdatabaseถ้ามีอยู่
  Future<Database> openDB() async{
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocate = join(appDirectory.path, dbName);
    //สร้าง database
    Database database = await databaseFactoryIo.openDatabase(dbLocate);
    
    return database;
  }
  //เพิ่มข้อมูลเข้าstore
  Future<int> insertDatabase(Transactions statement) async{
    var db = await this.openDB();
    var store = intMapStoreFactory.store('expense');

    var keyID  = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }
  //ดึงข้อมูลdatabaseมาใช้
  //new to old = false
  //old to new = true
  Future <List<Transactions>> loadAllData() async{
    var db = await this.openDB();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(db,finder: Finder(sortOrders: [SortOrder(Field.key,false)]));
    print(snapshot);
    List<Transactions> transactionlist = [];
    for(var record in snapshot) {
      transactionlist.add(
        Transactions(
          keyid: record.key,
          title: record["title"].toString(),
          amount: double.parse(record["amount"].toString()),
          date: DateTime.parse(record["date"].toString()),
        )
      );
    }
    return transactionlist;
  }

  //ลบข้อมูลในdatabase
  Future<void> deleteDb(int index) async{
    var db = await this.openDB();
    var store = intMapStoreFactory.store('expense');
    await store.delete(db, finder: Finder(.equals(Field.key, value)));
  }
}