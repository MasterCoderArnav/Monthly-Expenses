import 'package:demo2/models/transaction.dart';
import 'package:demo2/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

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
        child: widget.tx.isEmpty
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
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
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Container(
                height: 300,
                child: ListView.builder(
                  itemCount: widget.tx.length,
                  itemBuilder: (context, index) {
                    return TransactionItem(
                      tx: widget.tx[index],
                      deleteTransactionCallBack:
                          widget.deleteTransactionCallBack,
                    );
                  },
                ),
              ),
      ),
    );
  }
}
