import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  
  Transactions game;
  
  EditScreen({super.key, required this.game});

  @override
  State<EditScreen> createState() => _EditScreen();
}

class _EditScreen extends State<EditScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var amountController = TextEditingController();

  var genreController = TextEditingController();

  var agerecController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    nameController.text = widget.game.name;
    amountController.text = widget.game.amount.toString();
    genreController.text = widget.game.genre;
    agerecController.text = widget.game.agerec.toString();

    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อรายการ',
                  ),
                  autofocus: false,
                  controller: nameController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ระเภทของเกม',
                  ),
                  autofocus: false,
                  controller: genreController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'จำนวนเงิน',
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String? input) {
                    try {
                      double amount = double.parse(input!);
                      if (amount < 0) {
                        return 'กรุณากรอกข้อมูลมากกว่า 0';
                      }
                    } catch (e) {
                      return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'อายุที่แนะนำ',
                  ),
                  autofocus: false,
                  controller: agerecController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextButton(
                    child: const Text('บันทึก'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // create transaction data object
                        Transactions statement = Transactions(
                            keyid: widget.game.keyid,
                            name: widget.game.name,
                            amount: double.parse(amountController.text),
                            genre: widget.game.genre,
                            agerec: int.parse(agerecController.text));

                        // add transaction data object to provider
                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.updateTransaction(statement);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return MyHomePage();
                                }));
                      }
                    })
              ],
            )));
  }
}
