import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/transactions.dart';


class TransactionDB{
  
  /*static final TransactionDB _singleton = TransactionDB._();

  static TransactionDB get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  TransactionDB._();

  Future<Database> get database() async{

    if(_dbOpenCompleter == null){
      _dbOpenCompleter = Completer();

      _openDatabase();
    }
  }

  Future _openDatabase() async{

    final appDocumentDir = await getApplicationDocumentsDirectory();

    final dbPath = join(appDocumentDir.path, 'demo.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter.complete(database);
  }*/

  String dbName;

  TransactionDB({required this.dbName});
  //เรียกเปิดdatabaseถ้ามีอยู่
  Future<Database> openDatabase() async{
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocate = join(appDirectory.path, dbName);
    //สร้าง database
    DatabaseFactory dbFatory = await databaseFactoryIo;
    Database db = await dbFatory.openDatabase(dbLocate);
    return db;
  }
  //เพิ่มข้อมูลเข้าstore
  Future<int> insertDatabase(Transactions statement) async{
    var db = await this.openDatabase();
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
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var snapshot = await store.find(db,finder: Finder(sortOrders: [SortOrder(Field.key,false)]));
    print(snapshot);
    List<Transactions> transactionlist = [];
    for(var record in snapshot) {
      transactionlist.add(
        Transactions(
          title:record["title"].toString(),
          amount: double.parse(record["amount"].toString()),
          date: DateTime.parse(record["date"].toString()),
        )
      );
    }
    return transactionlist;
  }

  //ลบข้อมูลในdatabase
  Future<void> deleteDb() async{
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    await store.find(db,finder: Finder(filter: ));
  }
}