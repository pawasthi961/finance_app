import 'package:finance_app/screens/approvals/entry_requests.dart';
import 'package:finance_app/screens/approvals/payment_confirmation.dart';
import 'package:finance_app/screens/approvals/payment_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApprovalScreen extends StatefulWidget {
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen>
    with SingleTickerProviderStateMixin {
  int _pageIndex = 1;

  TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: _pageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            icon: GestureDetector(
              child: Stack(children: [
                Icon(
                  _pageIndex == 0
                      ? Icons.receipt_rounded
                      : Icons.receipt_outlined,
                ),
              ]),
            ),
            iconMargin: EdgeInsets.only(bottom: 10.0),
          ),
          Tab(
            icon: Icon(
              _pageIndex == 1 ? Icons.payments : Icons.payments_outlined,
            ),
            iconMargin: EdgeInsets.only(bottom: 10.0),
          ),
          Tab(
            icon: Icon(
              _pageIndex == 2
                  ? Icons.request_page_rounded
                  : Icons.request_page_outlined,
            ),
            iconMargin: EdgeInsets.only(bottom: 10.0),
          ),
        ],
        indicatorColor: Color(0xffDa0037),
        onTap: ((int page) {
          setState(() {
            _pageIndex = page;
          });
        }),
        // unselectedLabelColor: Colors.grey,
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            EntryRequestsView(),
            PaymentConfirmationView(),
            PaymentRequestsView(),
          ],
        ),
      )
    ]);
  }
}
