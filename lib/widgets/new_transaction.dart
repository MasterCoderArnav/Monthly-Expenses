import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionCallBack;

  NewTransaction({Key? key, required this.newTransactionCallBack})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime? _selectedDateTime;
  final _amountController = TextEditingController();

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);
    DateTime? dt = _selectedDateTime;
    if (title.isEmpty || amount <= 0 || dt == null) {
      return;
    }
    widget.newTransactionCallBack(
      title,
      amount,
      dt,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter Title',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0)),
              ),
              controller: _titleController,
              onSubmitted: (_) => submitData,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Amount',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0)),
              ),
              controller: _amountController,
              onSubmitted: (_) => submitData,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    _selectedDateTime == null
                        ? 'No date chosen!'
                        : DateFormat.yMd().format(_selectedDateTime!),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Platform.isIOS
                    ? CupertinoButton(
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime.now(),
                          ).then((pickedData) {
                            if (pickedData == null) {
                              return;
                            } else {
                              setState(() {
                                _selectedDateTime = pickedData;
                              });
                            }
                          });
                        },
                      )
                    : TextButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime.now(),
                          ).then((pickedData) {
                            if (pickedData == null) {
                              return;
                            } else {
                              setState(() {
                                _selectedDateTime = pickedData;
                              });
                            }
                          });
                        },
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: submitData,
                  child: const Text(
                    'Save Transaction',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
