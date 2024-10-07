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

  void addTransaction(Transactions game) async {
    var db = await TransactionDB(dbName: 'gamestorage.db');
    await db.insertDatabase(game);
    //ดึงข้อมูลมา
    transactions = await db.loadAllData();
    //แจ้งู้ใช้
    notifyListeners();
  }

  void deleteTransaction(int keyid) async {
    var db = await TransactionDB(dbName: 'gamestorage.db');
    await db.deleteDb(keyid);
    this.transactions.removeAt(keyid);
    notifyListeners();
  }

  void initData() async {
    var db = TransactionDB(dbName: 'gamestorage.db');
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void updateTransaction(Transactions game) async {
    var db = TransactionDB(dbName: 'gamestorage.db');
    await db.updateDatabase(game);
    this.transactions = await db.loadAllData();
    notifyListeners();
  }
}
