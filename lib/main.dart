import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions{
    
    return _userTransaction.where((element) {
      return element.date.isAfter(
          DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _requestAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id)
  {
    for(var i = 0 ; i < _userTransaction.length; i++)
    {
      if(_userTransaction[i].id == id)
      {
        setState(() {
          _userTransaction.removeAt(i);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.black45
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          centerTitle: true,
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () => _requestAddNewTransaction(context),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Charts(_recentTransactions),
              TransactionList(_userTransaction,_deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => _requestAddNewTransaction(context),
          ),
        ),
      ),
    );
  }
}
