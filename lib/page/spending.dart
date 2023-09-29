// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, unused_import, unnecessary_import, unnecessary_null_comparison, no_logic_in_create_state, unnecessary_this, prefer_const_constructors_in_immutables, library_prefixes, use_key_in_widget_constructors, sort_child_properties_last, unnecessary_string_interpolations, unnecessary_new

import 'package:certif_mobile_stuff/dir/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:certif_mobile_stuff/model/flow.dart' as myFlow;
import 'package:intl/intl.dart';

class Spending extends StatefulWidget {
  final myFlow.Flow flow = myFlow.Flow("", 0, "", "");

  @override
  _SpendingState createState() => _SpendingState(this.flow);
}

class _SpendingState extends State<Spending> {
  myFlow.Flow? flow;
  DBHelper dbHelper = DBHelper();

  _SpendingState(this.flow);

  TextEditingController value = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();

  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (flow != null) {
      value.text = flow!.value.toString();
      date.text = flow!.date;
      description.text = flow!.description;
    }

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
              Text("Income"),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                _buildDateField(date),
                SizedBox(
                  height: 20,
                ),
                _buildInputField(
                  icon: Icons.attach_money_outlined,
                  labelText: 'Nominal',
                  controller: value,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                _buildInputField(
                  icon: Icons.assignment_ind,
                  labelText: 'Description',
                  controller: description,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                _buildButton(
                  label: 'Reset',
                  onPressed: () {
                    setState(() {
                      value.clear();
                      date.clear();
                      description.clear();
                    });
                  },
                  backgroundColor: Color(0xffff6b6b),
                ),
                _buildButton(
                  label: 'Submit',
                  onPressed: () async {
                    print(int.parse(value.text));
                    print(description.text);
                    flow!.value = int.parse(value.text);
                    flow!.description = description.text;
                    flow!.date = date.text;
                    flow!.category = "spending";
                    var result = dbHelper.insertFlow(flow!);
                    if (result != 0) {
                      Navigator.pop(context);
                    }
                    value.clear();
                    date.clear();
                    description.clear();
                  },
                  backgroundColor: Color(0xff0074E4),
                ),
                _buildButton(
                  label: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Color(0xffff851b),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String labelText,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: labelText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(Icons.date_range_rounded),
          SizedBox(width: 8.0),
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Date',
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());

                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate!,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                setState(() {
                  date.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
                  selectedDate = pickedDate;
                  widget.flow.date = date.text;
                  date.text = "${widget.flow.date}" != "null"
                      ? "${widget.flow.date}"
                      : "${selectedDate!.toLocal()}".split(' ')[0];
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required Function onPressed,
    required Color backgroundColor,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(
          label,
        ),
        onPressed: onPressed as void Function()?,
      ),
    );
  }
}
