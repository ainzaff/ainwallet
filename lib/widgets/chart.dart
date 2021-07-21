import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import "./bar.dart";

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double sum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          sum += recentTransactions[i].amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupedTransactions.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: Bar(
                  (e["day"] as String),
                  (e["amount"] as double),
                  (totalSpending == 0
                      ? 0
                      : (e["amount"] as double) / totalSpending),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          "TOTAL SPENDING : RM ${totalSpending.toStringAsFixed(2)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ]);
  }
}
