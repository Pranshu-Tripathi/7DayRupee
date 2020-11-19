import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Charts(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'Amount': totalSum,
      };
    }).reversed.toList();
  }


  double get maxspending{
    return groupedTransactionValues.fold(0.0, (sum,item) {
      return sum + item['Amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return ChartBar(data['Day'],data['Amount'],
                  maxspending == 0 ? 0.0 :(data['Amount'] as double) / maxspending);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
