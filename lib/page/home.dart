// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_import

import 'package:certif_mobile_stuff/page/cash_flow.dart';
import 'package:certif_mobile_stuff/page/income.dart';
import 'package:certif_mobile_stuff/page/setting.dart';
import 'package:certif_mobile_stuff/page/spending.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financium"),
        backgroundColor: Color(0xff0074E4),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle the notifications button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 15,
                left: 8,
                right: 8,
              ),
              //Initialize the spark charts widget
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(
                    text: 'Income and Spending Statistics',
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _buildCard(
                    icon: Icons.file_download_outlined,
                    label: "Add Income",
                    routeName: Income(),
                  ),
                  _buildCard(
                    icon: Icons.moving_rounded,
                    label: "Add Spending",
                    routeName: Spending(),
                  ),
                  _buildCard(
                    icon: Icons.cached_sharp,
                    label: "Cash Flow Detail",
                    routeName: CashFlow(),
                  ),
                  _buildCard(
                    icon: Icons.settings,
                    label: "Setting",
                    routeName: Setting(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String label,
    required Widget routeName,
  }) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => routeName),
            );
          },
          splashColor: Color(0xff0074E4),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 50.0,
                  color: Color(0xff0074E4),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xff0074E4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
