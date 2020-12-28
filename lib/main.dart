import './widgets/Chart.dart';
import './widgets/Transactions_List.dart';
import './widgets/new_Transaction.dart';
import 'package:flutter/material.dart';
import './models/Transaction.dart';

void main() => runApp(_myApp());

class _myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses Tracker",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void add_Transaction(transaction){
    setState(() {
      transactions.add(transaction);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return new_Transaction(
            add_Transaction,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Expenses Tracker"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  startAddNewTransaction(context);
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Chart(_recentTransactions),
              transactions_List(transactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            }));
  }
}
