import 'package:flutter/foundation.dart';
import 'package:account/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [
    Transaction(title: 'Monster Hunter World', amount: 243.87, genre: 'Open World, Actions, RPG, Multiplayer'),
    Transaction(title: 'Elden Ring', amount: 1253, genre: 'Open World, Dark Fantasy, RPG'),
    Transaction(title: 'ARK: Survival Evolved', amount: 315, genre: 'Open World Survival Craft, Survival, Muliplayer'),
  ];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners(); 
  }
}