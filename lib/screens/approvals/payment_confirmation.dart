import 'package:finance_app/widgets/approvals/payment_confirmation_particular_tile.dart';
import 'package:finance_app/widgets/approvals/payment_confirmation_settle_tile.dart';
import 'package:flutter/material.dart';

class PaymentConfirmationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PaymentConfirmationParticularTile(),
          PaymentConfirmationSettleTile(),
        ],
      ),
    );
  }
}
