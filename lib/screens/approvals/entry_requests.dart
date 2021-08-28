import 'package:finance_app/widgets/approvals/entry_request_tile.dart';
import 'package:flutter/material.dart';

class EntryRequestsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [EntryRequestTile()],
      ),
    );
  }
}
