import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  const TransactionList({this.transactions, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return renderList(context, transactions, onRemove);
  }
}

Widget renderList(BuildContext context, List<Transaction> transactions,
    Function(String) onRemove) {
  if (transactions.isEmpty) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: Text(
                "Nenhuma transação cadastrada",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.65,
              child: Image.asset(
                "assets/images/waiting.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }

  return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tr = transactions[index];

        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text("R\$${tr.value}"),
                ),
              ),
            ),
            title: Text(
              tr.title,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(DateFormat("d MMM y").format(tr.date)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => onRemove(tr.id),
            ),
          ),
        );
      });
}
