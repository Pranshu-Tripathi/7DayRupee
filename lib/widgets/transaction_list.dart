import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function _deteteTx;

  TransactionList(this._userTransaction, this._deteteTx);

  void _deleteRequest(Transaction t) {
    if (t != null) _deteteTx(t.id);
  }

  @override
  Widget build(BuildContext context) {
    return _userTransaction.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "No Transactions Made Yet!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
              ),
              Container(
                height: 250,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, i) {
              return Card(
                elevation: 6,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('${_userTransaction[i].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${_userTransaction[i].title}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                      '${DateFormat.yMMMd().format(_userTransaction[i].date)}'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                    onPressed: () => _deleteRequest(_userTransaction[i]),
                  ),
                ),
              );
            },
            itemCount: _userTransaction.length,
          );
  }
}
