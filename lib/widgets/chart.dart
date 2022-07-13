import 'package:demo2/models/transaction.dart';
import 'package:demo2/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> transactions;
  const Chart({Key? key, required this.transactions}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      double totalSum = 0;
      final weekDay = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < widget.transactions.length; i++) {
        if (widget.transactions[i].dt.day == weekDay.day &&
            widget.transactions[i].dt.month == weekDay.month &&
            widget.transactions[i].dt.year == weekDay.year) {
          totalSum += widget.transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'] as String,
                spending: data['amount'] as double,
                spendingPercent: totalSpending == 0
                    ? 0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
