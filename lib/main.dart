import 'package:demo2/widgets/chart.dart';
import 'package:demo2/widgets/new_transaction.dart';
import 'package:demo2/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second App of the course',
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14.0,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(newTransactionCallBack: addTransaction),
        );
      },
    );
  }

  final List<Transaction> tx = [];

  void addTransaction(String title, double amount, DateTime chosenDate) {
    final newTX = Transaction(
      amount: amount,
      dt: chosenDate,
      id: DateTime.now().toString(),
      title: title,
    );
    setState(
      () {
        tx.add(newTX);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(
      () {
        tx.removeWhere((transaction) => transaction.id == id);
      },
    );
  }

  List<Transaction> get _recentTransaction {
    return tx.where((transaction) {
      return transaction.dt.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Expenses'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: () => startAddTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Chart(
              transactions: _recentTransaction,
            ),
            TransactionList(
              tx: tx,
              deleteTransactionCallBack: _deleteTransaction,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
