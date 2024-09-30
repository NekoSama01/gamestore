import 'package:account/databases/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transactions.dart';
import 'package:sembast/sembast.dart';

class TransactionProvider with ChangeNotifier {
  /*static const String GAME_STORE_NAME = 'games';

  final _gameStore = intMapStoreFactory.store(GAME_STORE_NAME);
  //pull the database to _db
  Future<Database> get _db async => await TransactionDB.instance.database;

  Future insert(Transactions game) async{
    await _gameStore.add(await _db, game.toMap());
  }

  Future update(Transactions game) async{
    final finder = Finder(filter: Filter.byKey(game.id));
    await _gameStore.update(
      await _db,
      game.toMap(),
      finder:finder,
    );
  }

  Future delete(Transactions game) async{
    final finder = Finder(filter: Filter.byKey(game.id));
    await _gameStore.delete(
      await _db,
      finder : finder,
    );
  }*/
  
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions statement) async{
    var db = await TransactionDB(dbName: 'transactions.db');
    await db.insertDatabase(statement);
    //ดึงข้อมูลมา
    transactions = await db.loadAllData();
    //แจ้งู้ใช้
    notifyListeners();
  }

  void deleteTransaction(int index) async{
    var db = await TransactionDB(dbName: 'transactions.db');
    await db.deleteDb(index);
    transactions.removeAt(index);
    notifyListeners(); 
  }

  void initData() async{
    var db = TransactionDB(dbName: 'transactions.db');
    transactions = await db.loadAllData();
    notifyListeners();
  }
}
