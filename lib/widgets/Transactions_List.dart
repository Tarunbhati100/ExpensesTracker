import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class transactions_List extends StatelessWidget {
  final List<Transaction> transactions;
  Function function;

  transactions_List(
    this.transactions,
    this.function,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Image.asset("assets/images/panda-waiting.png"),
              Text(
                "No Data Has been Added Yet !",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )
        : Container(
            height: 350,
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              )),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Rs. " + transactions[index].amount.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transactions[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                DateFormat.yMMMMd()
                                    .format(transactions[index].date),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        function(transactions[index].id);
                      },
                    )
                  ]),
                );
              },
            ),
          );
  }
}
