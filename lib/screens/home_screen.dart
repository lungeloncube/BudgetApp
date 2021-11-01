import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/transaction.dart';
import './transactions/daily_spendings.dart';
import './transactions/monthly_spendings.dart';
import './transactions/yearly_spendings.dart';
import '../widgets/app_drawer.dart';
import './new_transaction.dart';
import './transactions/weekly_spendings.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var daily = "Daily";
  var weekly = "Weekly";
  var monthly = "Monthly";
  var yearly = "Yearly";

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(NewTransaction.routeName)),
        ],
        bottom: new TabBar(
          unselectedLabelColor: Colors.blue[900],
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          tabs: <Widget>[
            new Tab(
              text: daily,
            ),
            new Tab(
              text: weekly,
            ),
            new Tab(
              text: monthly,
            ),
            new Tab(
              text: yearly,
            ),
          ],
          controller: tabController,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<Transactions>(context, listen: false)
            .fetchTransactions(),
        builder: (ctx, snapshot) =>
            (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: <Widget>[
                      new DailySpendings(
                        name: daily,
                      ),
                      new WeeklySpendings(
                        name: weekly,
                      ),
                      new MonthlySpendings(
                        name: monthly,
                      ),
                      new YearlySpendings(
                        name: yearly,
                      ),
                    ],
                    controller: tabController,
                  ),
      ),
      drawer: Consumer<Transactions>(
        builder: (context, trx, child) {
          return AppDrawer(total: trx.getTotal(trx.transactions));
        },
      ),
    );
  }
}
