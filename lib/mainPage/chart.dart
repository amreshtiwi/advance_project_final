import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var confirmed = 16.0, death = 5.0, recoveries = 14.0;

class Chart extends StatefulWidget {
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<Task> _chartData;
  late TooltipBehavior _toolTipBehaviour;
  @override
  void initState() {
    _chartData = getChartData();
    _toolTipBehaviour = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 360,
          child: SfCircularChart(
            title: ChartTitle(text: ''),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: _toolTipBehaviour,
            series: <CircularSeries>[
              PieSeries<Task, String>(
                  dataSource: _chartData,
                  xValueMapper: (Task data, _) => data.name,
                  yValueMapper: (Task data, _) => data.value,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
          ),
        )
      ],
    );
  }
}

List<Task> getChartData() {
  final List<Task> chartData = [
    Task("Confirmed", confirmed, Colors.red),
    Task("Recoveries", recoveries, Color.fromARGB(255, 57, 8, 156)),
    Task("Death", death, Color.fromARGB(255, 2, 79, 50)),
  ];
  return chartData;
}

class Task {
  final String name;
  final double value;
  final Color color;

  Task(this.name, this.value, this.color);
}
