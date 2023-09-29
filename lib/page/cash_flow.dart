// ignore_for_file: use_build_context_synchronously, unnecessary_this, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, use_key_in_widget_constructors, unnecessary_cast, depend_on_referenced_packages, unnecessary_import, unused_local_variable, unused_import, library_prefixes, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:certif_mobile_stuff/dir/DBHelper.dart';
import 'package:certif_mobile_stuff/model/flow.dart' as myFlow;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class CashFlow extends StatefulWidget {
  @override
  _CashFlowState createState() => _CashFlowState();
}

// Show data flow
class _CashFlowState extends State<CashFlow> {
  DBHelper dbHelper = DBHelper();
  int count = 0;
  List<myFlow.Flow> flowList = [];

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0074E4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          child: Row(
            children: [
              Text("Cash Flow"),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                IconData iconData;
                Color iconColor;

                if (this.flowList[index].category == "income") {
                  iconData = Icons.arrow_back_outlined;
                  iconColor = Colors.green;
                } else if (this.flowList[index].category == "spending") {
                  iconData = Icons.arrow_forward_outlined;
                  iconColor = Colors.red;
                } else {
                  iconData = Icons.error_outline;
                  iconColor = Colors.black;
                }

                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.currency_exchange_outlined,
                      color: Colors.black,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.flowList[index].description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Rp." + this.flowList[index].value.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    subtitle: Text(this.flowList[index].date.toString()),
                    trailing: IconButton(
                      icon: Icon(
                        iconData,
                        color: iconColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateListView() async {
    final Database database =
        await dbHelper.initDatabase(); // Await the database initialization
    final List<myFlow.Flow> flowList =
        await dbHelper.getFlows(); // Await the list retrieval

    setState(() {
      this.flowList = flowList;
      this.count = flowList.length;
    });
  }

  void _delete(BuildContext context, myFlow.Flow flow) async {
    int result = await dbHelper.deleteFlow(flow.id);
    if (result != 0) {
      updateListView();
    }
  }
}
