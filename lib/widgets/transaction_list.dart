import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> txlist;
  final Function delete;
  TransactionList(this.txlist, this.delete);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 660,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: const Color.fromRGBO(200, 0, 0, 1),
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "RM${widget.txlist[index].amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Column(children: [
                      Text(
                        widget.txlist[index].title,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMMd().format(widget.txlist[index].date),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    SizedBox(width: 40),
                    IconButton(
                      onPressed: () {
                        widget.delete(widget.txlist[index].id);
                      },
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: widget.txlist.length,
          ),
        ),
      ],
    );
  }
}
