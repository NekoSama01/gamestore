import 'package:meta/meta.dart';

class Transactions {
  late int? keyid;
  final String name;
  final double amount;
  final String genre;
  final int agerec;

  Transactions({
    this.keyid,
    required this.name,
    required this.amount,
    required this.genre,
    required this.agerec,
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