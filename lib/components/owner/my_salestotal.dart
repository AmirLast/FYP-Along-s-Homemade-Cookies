import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fyp/models/orderclass.dart';

class MySalesTotal extends StatefulWidget {
  const MySalesTotal({super.key});

  @override
  State<MySalesTotal> createState() => _MySalesTotalState();
}

class _MySalesTotalState extends State<MySalesTotal> {
  final totQuant = <Map<String, int>>[];
  final List<Color> colors = [];
  var orders = Orders.currentOrder.orders.where((x) => x.status == "Confirm").toList();
  List<PieChartSectionData> pieCharts = [];
  int allQuant = 0;
  late DateTime date1;
  late DateTime date2;

  void setRange(DateTime a, DateTime b) {
    date1 = a;
    date2 = b;
  }

  void getAllData() {
    int i = 0;
    //for every order
    for (i; i < orders.length; i++) {
      int j = 0;
      //for every item in order
      for (j; j < orders[i].cartitems.length; j++) {
        String name = orders[i].cartitems[j].values.elementAt(2);
        int quantity = orders[i].cartitems[j].values.elementAt(0);
        int x = 0;
        bool exist = false;
        //if empty, add the product name and quantity
        if (totQuant.isEmpty) {
          totQuant.add({name: quantity});
          exist = true; //prod exist now
        } else {
          //check each list if exist current prod name
          for (x; x < totQuant.length; x++) {
            if (totQuant[x].containsKey(name)) {
              //if exist, sum up the prod quantity with current quantity
              int newQ = totQuant[x].values.first + quantity;
              totQuant[x].update(name, (value) => newQ); //update
              exist = true; //prod name found in list
            }
          }
        }
        if (!exist) {
          //if not found in list, add it
          totQuant.add({name: quantity});
        }
      }
    }
  }

  void makeChartData() {
    int i = 0;
    for (i; i < totQuant.length; i++) {
      int q = totQuant[i].values.first;
      //the random color
      Color theColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 1.0);
      //process to make a lighten color
      final hsl = HSLColor.fromColor(theColor);
      final hslLight = hsl.withLightness((hsl.lightness).clamp(0.55, 0.7));
      //final color
      colors.add(hslLight.toColor());
      pieCharts.add(
        PieChartSectionData(
          value: double.parse("$q"),
          title: "${(q / allQuant * 100).toStringAsFixed(0)}%",
          titleStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          showTitle: true,
          radius: 100,
          color: colors[i],
          titlePositionPercentageOffset: 0.75,
        ),
      );
    }
  }

  void toCalculate() {
    orders =
        orders.where((x) => DateTime.parse(x.onchange).compareTo(date1) >= 0 && DateTime.parse(x.onchange).compareTo(date2) <= 0).toList();
    getAllData();
    totQuant.sort((a, b) => a.keys.first.compareTo(b.keys.first));
    int i = 0;
    for (i; i < totQuant.length; i++) {
      allQuant += totQuant[i].values.first;
    }
    makeChartData();
  }

  @override
  void initState() {
    super.initState();
    setRange(DateTime(2025, 1, 1), DateTime(2025, 12, 31));
    toCalculate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            "Product Quantity Sold ($allQuant Items)",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 200,
            height: totQuant.isEmpty ? 100 : 200,
            child: totQuant.isEmpty
                ? Center(
                    child: Text(
                      "Nothing to show yet...",
                      style: TextStyle(color: Colors.black.withValues(alpha: 0.4), fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  )
                : PieChart(
                    PieChartData(
                      sections: pieCharts,
                    ),
                  ),
          ),
          Row(
            children: [
              totQuant.isEmpty ? const SizedBox(height: 20) : Container(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.only(bottom: 5),
                  itemCount: totQuant.length,
                  itemBuilder: (context, index) {
                    return index.isEven
                        ? Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: colors[index],
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(width: 100, child: Text(totQuant[index].keys.first, overflow: TextOverflow.ellipsis)),
                              Text(" ${totQuant[index].values.first}"),
                            ],
                          )
                        : Container();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.only(bottom: 5),
                  itemCount: totQuant.length,
                  itemBuilder: (context, index) {
                    return index.isOdd
                        ? Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: colors[index],
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(width: 100, child: Text(totQuant[index].keys.first, overflow: TextOverflow.ellipsis)),
                              Text(" ${totQuant[index].values.first}"),
                            ],
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
