import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/orderclass.dart';
import 'dart:math' as math;

class MySalesPerMonth extends StatefulWidget {
  const MySalesPerMonth({super.key});

  @override
  State<MySalesPerMonth> createState() => _MySalesPerMonthState();
}

class _MySalesPerMonthState extends State<MySalesPerMonth> {
  int year = DateTime.now().year;
  var orders =
      Orders.currentOrder.orders.where((x) => x.status == "Confirm" && DateTime.parse(x.onchange).year == DateTime.now().year).toList();
  List<FlSpot> listSpot = [];
  double minQ = 0;
  double maxQ = 0;
  late Color color = Colors.black;

  @override
  void initState() {
    super.initState();
    //the random color
    Color theColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 1.0);
    //process to make a lighten color
    final hsl = HSLColor.fromColor(theColor);
    final hslLight = hsl.withLightness((hsl.lightness).clamp(0.55, 0.7));
    //final color
    color = hslLight.toColor();
    orders.sort((a, b) => DateTime.parse(a.onchange).compareTo(DateTime.parse(b.onchange)));
    int j = 12; //DateTime.parse(orders.last.onchange).month;
    //for each month 1~12//for the month done for this year
    for (int i = 1; i <= j; i++) {
      double y = 0;
      //search all orders
      for (int j = 0; j < orders.length; j++) {
        //if month of order is same with current month only
        if (DateTime.parse(orders[j].onchange).month == i) {
          //for each product in that order
          for (int k = 0; k < orders[j].cartitems.length; k++) {
            int quantity = orders[j].cartitems[k].values.elementAt(0);
            double price = orders[j].cartitems[k].values.elementAt(1);
            //sum the total of price x quantity of each cart items
            y += price * quantity;
          }
        }
      }
      //just for the test
      if (y == 0) {
        y = (math.Random().nextDouble() % 1000) * 1000;
      }
      if (i == 1) {
        minQ = y;
      } else {
        if (minQ > y) {
          minQ = y;
        }
      }
      if (maxQ < y) {
        maxQ = y;
      }
      listSpot.add(FlSpot(i.toDouble(), y));
    }
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
            "(RM) Sales Monthly in $year",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 350,
            height: orders.isEmpty ? 100 : 350,
            child: orders.isEmpty
                ? Center(
                    child: Text(
                      "Nothing to show yet...",
                      style: TextStyle(color: Colors.black.withValues(alpha: 0.4), fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipColor: (touchedSpot) {
                              return Colors.black;
                            },
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((flspot) {
                                return LineTooltipItem("RM${flspot.y.toStringAsFixed(2)}", TextStyle(color: color));
                              }).toList();
                            },
                          ),
                        ),
                        minY: minQ < 50 ? -50 : 0,
                        maxY: maxQ % 100 < 50 ? maxQ + (100 - (maxQ % 100)) : maxQ + (100 - (maxQ % 100)) + 50, //to get even x limit
                        minX: 1,
                        maxX: 12,
                        lineBarsData: [
                          LineChartBarData(
                            color: color,
                            barWidth: 5,
                            isCurved: false,
                            spots: listSpot,
                          )
                        ],
                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                            axisNameWidget: Text(
                              "*touch vertical line to show data",
                              style: TextStyle(color: Colors.black.withValues(alpha: 0.7), fontSize: 10, fontStyle: FontStyle.italic),
                            ),
                            sideTitles: const SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 35,
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                    child: Text(
                                      value.toStringAsFixed(0),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    axisSide: AxisSide.left);
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                String month = "";
                                switch (value.toInt()) {
                                  case 1:
                                    month = "Jan";
                                    break;
                                  case 2:
                                    month = "Feb";
                                    break;
                                  case 3:
                                    month = "Mar";
                                    break;
                                  case 4:
                                    month = "Apr";
                                    break;
                                  case 5:
                                    month = "May";
                                    break;
                                  case 6:
                                    month = "Jun";
                                    break;
                                  case 7:
                                    month = "Jul";
                                    break;
                                  case 8:
                                    month = "Aug";
                                    break;
                                  case 9:
                                    month = "Sep";
                                    break;
                                  case 10:
                                    month = "Oct";
                                    break;
                                  case 11:
                                    month = "Nov";
                                    break;
                                  case 12:
                                    month = "Dec";
                                    break;
                                  default:
                                    break;
                                }
                                return SideTitleWidget(
                                    child: Text(
                                      month,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    axisSide: AxisSide.bottom);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
