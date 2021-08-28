import 'package:finance_app/widgets/approvals/payment_request_particular_tile.dart';
import 'package:finance_app/widgets/approvals/payment_request_settle_tile.dart';
import 'package:flutter/material.dart';

class PaymentRequestsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PaymentRequestSettleTile(),
          PaymentRequestParticularTile(),
        ],
      ),
    );
  }
}
