import 'package:finance_app/widgets/transaction_overview_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TransactionOverviewTile(),
          TransactionOverviewTile(),
          TransactionOverviewTile(),
          TransactionOverviewTile(),
          TransactionOverviewTile()
        ],
      ),
    );
  }
}
