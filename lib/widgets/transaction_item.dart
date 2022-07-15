import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  final Function deleteTransactionCallBack;
  const TransactionItem({
    Key? key,
    required this.tx,
    required this.deleteTransactionCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: Text(
          "\$${tx.amount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        title: Text(
          tx.title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(
            tx.dt,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => deleteTransactionCallBack(
                  tx.id,
                ),
                icon: const Icon(Icons.delete),
                label: const Text('Remove List Item'),
              )
            : IconButton(
                onPressed: () => deleteTransactionCallBack(
                  tx.id,
                ),
                icon: const Icon(
                  Icons.delete,
                ),
              ),
      ),
    );
  }
}
