import 'package:intl/intl.dart';
import '../models/Transaction.dart';
import 'package:flutter/material.dart';

class new_Transaction extends StatefulWidget {
  Function function1;
  new_Transaction(
    this.function1,
  );

  @override
  _new_TransactionState createState() => _new_TransactionState();
}

class _new_TransactionState extends State<new_Transaction> {
  final _titlecontroler = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime _selectedDate;
  //String inputtitle;
  //String inputamount;

  void _submitdata() {
    String title = _titlecontroler.text;
    double amount = double.parse(_amountcontroller.text);
    
        if (_titlecontroler.text.isEmpty ||
        (double.parse(_amountcontroller.text) <= 0 ||
            _amountcontroller.text.isEmpty) ||
        _selectedDate == null) {
      return;
    }
    widget.function1(Transaction(
        amount: amount,
        title: title,
        date: _selectedDate,
        id: DateTime.now().toString()));
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  // onChanged: (val){(inputtitle= val);},
                  controller: _titlecontroler,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  //onChanged: (val){(inputamount= val);},
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          (_selectedDate == null)
                              ? "No Date is Chosen!"
                              : "Picked Date : " +
                                  DateFormat.yMd().format(_selectedDate),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _submitdata();
                  },
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
