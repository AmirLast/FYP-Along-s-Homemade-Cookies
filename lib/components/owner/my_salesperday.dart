import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/orderclass.dart';

class MySalesPerDay extends StatefulWidget {
  const MySalesPerDay({super.key});

  @override
  State<MySalesPerDay> createState() => _MySalesPerDayState();
}

class _MySalesPerDayState extends State<MySalesPerDay> {
  var orders = Orders.currentOrder.orders.where((x) => x.status == "Confirm").toList();
  List<BarChartGroupData> listData = [];
  late List<Map<String, int>> firstProds = [];
  late List<Map<String, int>> secondProds = [];
  late List<String> prodNames = [];
  late List<int> percentage = [];
  //from xRange1 until xRange2
  late DateTime xRange1;
  late DateTime xRange2;
  //from yRange1 until yRange2
  late DateTime yRange1;
  late DateTime yRange2;

  void setRange(DateTime x1, DateTime x2, DateTime y1, DateTime y2) {
    xRange1 = x1;
    xRange2 = x2;
    yRange1 = y1;
    yRange2 = y2;
  }

  List<Map<String, int>> setListProduct(List<Orders> o) {
    List<Map<String, int>> list = [];
    int i = 0;
    //for every order
    for (i; i < o.length; i++) {
      int j = 0;
      //for every item in order
      for (j; j < o[i].cartitems.length; j++) {
        String name = o[i].cartitems[j].values.elementAt(2);
        int quantity = o[i].cartitems[j].values.elementAt(0);
        int x = 0;
        bool exist = false;
        if (list.isEmpty) {
          list.add({name: quantity});
          exist = true; //prod exist now
        } else {
          //check each list if exist current prod name
          for (x; x < list.length; x++) {
            if (list[x].containsKey(name)) {
              //if exist, sum up the prod quantity with current quantity
              int newQ = list[x].values.first + quantity;
              list[x].update(name, (value) => newQ); //update
              exist = true; //prod name found in list
            }
          }
        }
        if (!exist) {
          //if not found in list, add it
          list.add({name: quantity});
        }
      }
    }
    return list;
  }

  void setListName(List<Map<String, int>> first, List<Map<String, int>> second) {
    prodNames.clear();
    List<Map<String, int>> combine = first + second;
    combine.sort((a, b) => a.keys.first.compareTo(b.keys.first)); //sort by name
    int i = 0;
    int j = 0;
    for (i; i < combine.length; i++) {
      bool exist = false;
      String name = combine[i].keys.first;
      if (prodNames.isEmpty) {
        prodNames.add(name);
        exist = true;
      } else {
        j = 0;
        for (j; j < prodNames.length; j++) {
          if (prodNames[j] == name) {
            exist = true;
          }
        }
      }
      if (!exist) {
        prodNames.add(name);
      }
    }
  }

  void setBarChartData() {
    percentage.clear();
    int i = 0;
    int j = prodNames.length;
    for (i; i < j; i++) {
      var a = firstProds.firstWhere((x) => x.keys.first == prodNames[i], orElse: () => {});
      var b = secondProds.firstWhere((x) => x.keys.first == prodNames[i], orElse: () => {});
      double prev = a.isEmpty ? 0 : double.parse("${a.values.first}");
      double curr = b.isEmpty ? 0 : double.parse("${b.values.first}");
      bool usePrev = prev > curr;
      double high = usePrev ? prev : curr;
      double low = !usePrev ? prev : curr;
      Color highC = usePrev ? Colors.white : Colors.green;
      Color lowC = usePrev ? Colors.red : Colors.white;
      if (prev == 0) {
        if (curr == 0) {
          percentage.add(0);
        } else {
          percentage.add(100);
        }
      } else {
        percentage.add(((curr - prev) / prev * 100).toInt());
      }

      listData.add(
        BarChartGroupData(
          x: i,
          barsSpace: 0,
          showingTooltipIndicators: [0],
          barRods: [
            BarChartRodData(
              toY: high,
              rodStackItems: [
                BarChartRodStackItem(0, low, lowC),
                BarChartRodStackItem(low, high, highC),
              ],
              borderRadius: BorderRadius.zero,
              width: 20,
            ),
          ],
        ),
      );
    }
  }

  void toCompare() {
    var firstOrders = orders
        .where((x) => DateTime.parse(x.onchange).compareTo(xRange1) >= 0 && DateTime.parse(x.onchange).compareTo(xRange2) <= 0)
        .toList();
    var secondOrders = orders
        .where((y) => DateTime.parse(y.onchange).compareTo(yRange1) >= 0 && DateTime.parse(y.onchange).compareTo(yRange2) <= 0)
        .toList();
    firstProds = setListProduct(firstOrders);
    secondProds = setListProduct(secondOrders);
    setListName(firstProds, secondProds);
    setBarChartData();
  }

  @override
  void initState() {
    super.initState();
    setRange(DateTime(2025, 1, 1, 0, 0), DateTime(2025, 1, 3, 23, 59), DateTime(2025, 1, 4, 0, 0), DateTime(2026, 1, 31, 23, 59));
    toCompare();
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
          const Text(
            "Product Quantity Sold (W1 vs W2)",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          listData.isEmpty
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("Previous"),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("Current"),
                      ],
                    ),
                  ],
                ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber.withValues(alpha: 0.3),
            ),
            margin: const EdgeInsets.only(bottom: 10, top: 15),
            padding: const EdgeInsets.fromLTRB(0, 15, 25, 5),
            width: 350,
            height: listData.isEmpty ? 100 : 350,
            child: listData.isEmpty
                ? Center(
                    child: Text(
                      "Nothing to show yet...",
                      style: TextStyle(color: Colors.black.withValues(alpha: 0.4), fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  )
                : BarChart(
                    BarChartData(
                        backgroundColor: Colors.amber.withValues(alpha: 0.5),
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipMargin: 5,
                            tooltipPadding: const EdgeInsets.fromLTRB(5, 3, 5, 0),
                            tooltipBorder: const BorderSide(color: Colors.black),
                            getTooltipColor: (group) {
                              return Colors.white;
                            },
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              String text = percentage[groupIndex].toString() + "%";
                              TextStyle textStyle = const TextStyle(color: Colors.black, fontSize: 10);
                              return BarTooltipItem(text, textStyle);
                            },
                          ),
                        ),
                        alignment: BarChartAlignment.center,
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                String item = prodNames[value.toInt()]; //get product name
                                item = item.substring(0, 3) + "..";
                                return SideTitleWidget(child: Text(item), axisSide: meta.axisSide);
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return SideTitleWidget(child: Text(meta.formattedValue), axisSide: meta.axisSide);
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) => value % 10 == 0,
                          getDrawingHorizontalLine: (value) => const FlLine(
                            color: Colors.amber,
                            strokeWidth: 1,
                          ),
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        groupsSpace: 20,
                        barGroups: listData //getData(8, 4),
                        ),
                  ),
          ),
        ],
      ),
    );
  }
}
