import 'package:ain_wallet/widgets/new_transaction.dart';
import 'package:ain_wallet/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import "/widgets/chart.dart";
import "/models/transaction.dart";

void main() {
  runApp(_AinWallet());
}

class _AinWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "AinWallet",
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(160, 0, 0, 1),
          colorScheme: ColorScheme.fromSwatch(),
          fontFamily: "ABeeZee",
        ),
        home: _HomePage());
  }
}

class _HomePage extends StatefulWidget {
  @override
  __HomePageState createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  final List<Transaction> _txlist = [];
  List<Transaction> get _recentTransactions {
    return _txlist.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String? title, String? amount, DateTime? date) {
    if (amount == null || title == null || date == null) {
      return;
    }
    setState(() {
      _txlist.add(new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: date,
      ));
    });
  }

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _txlist.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              _startAddTransaction(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
        centerTitle: true,
        title: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/wallet.png",
                fit: BoxFit.fill,
              ),
            ),
            Text(
              "AIN",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Wallet",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromRGBO(255, 0, 0, 1),
              const Color.fromRGBO(60, 0, 0, 1),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Chart(_recentTransactions),
              _txlist.isEmpty
                  ? Container(
                      height: 495,
                      child: Column(children: [
                        Image.asset("assets/notx.png"),
                        Text("NO TRANSACTIONS ADDED YET",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ]),
                    )
                  : TransactionList(_txlist, _deleteTransaction),
            ],
          ),
        ),
      ),
    );
  }
}
