import 'package:meta/meta.dart';

class Transactions {
  late int? keyid;
  final String title;
  final double amount;
  final DateTime date;

  Transactions({
    this.keyid,
    required this.title,
    required this.amount,
    required this.date,
  });

  /*Map<String, dynamic> toMap(){
    return {
      'name' : title,
      'amount': amount,
      'date': date,
    };
  }

  static Transactions fromMap(Map<String, dynamic>map) {
    return Transactions(
      title: map['name'],
      amount: map['amount'],
      date: map['date']
    );
  }*/
}