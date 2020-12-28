import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/models/Transaction.dart';
import 'package:my_first_app/widgets/ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenttransaction;
  Chart(this.recenttransaction);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recenttransaction.length; i++) {
        if (recenttransaction[i].date.day == weekday.day &&
            recenttransaction[i].date.month == weekday.month &&
            recenttransaction[i].date.year == weekday.year)
          totalSum += (recenttransaction[i].amount);
      }
      return {"day": DateFormat.E().format(weekday), "amount": totalSum};
    }).reversed.toList();
  }

  double totalspendings = 0.0;
  double get totalspending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((fx) {
            return Flexible(
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.all(10),
                child: ChartBar(
                    fx['day'],
                    fx['amount'],
                    totalspending == 0.0
                        ? 0.0
                        : ((fx['amount'] as double) / totalspending)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
