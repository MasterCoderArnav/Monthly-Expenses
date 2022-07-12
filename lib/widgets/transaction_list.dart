import 'package:demo2/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> tx;
  final Function deleteTransactionCallBack;
  const TransactionList(
      {Key? key, required this.tx, required this.deleteTransactionCallBack})
      : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 400,
        child: widget.tx.isEmpty
            ? Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'No transactions added yet!!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        height: 200,
                        child: Image.asset(
                          "assets/images/waiting.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: widget.tx.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: ListTile(
                      leading: Text(
                        "\$${widget.tx[index].amount.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        widget.tx[index].title,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(widget.tx[index].dt),
                      ),
                      trailing: IconButton(
                        onPressed: () => widget
                            .deleteTransactionCallBack(widget.tx[index].id),
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
