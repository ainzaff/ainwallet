import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function add;

  NewTransaction(this.add);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();
  DateTime? txdate;
  void submitData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        txdate == null ||
        double.parse(amountController.text) <= 0) {
      return;
    }

    widget.add(titleController.text, amountController.text, txdate);

    Navigator.of(context).pop();
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        txdate = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          margin: EdgeInsets.all(10),
          child: TextField(
            autofocus: true,
            onSubmitted: (_) => submitData(),
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (_) => submitData(),
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: InputDecoration(
              hintText: "Amount",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text(
                "Choose date",
              ),
              onPressed: pickDate,
            ),
            Expanded(
              child: Text(
                txdate == null
                    ? "No date chosen"
                    : "${DateFormat.yMd().format((txdate as DateTime))}",
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            submitData();
          },
          child: Text(
            "Confirm",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red[600],
            shadowColor: const Color.fromRGBO(50, 0, 0, 1),
            elevation: 20,
            padding: EdgeInsets.all(10),
          ),
        )
      ],
    );
  }
}
