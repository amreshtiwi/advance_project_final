import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Chart extends StatefulWidget {
  var newCases;
  var newDeaths;
  var cumlativeCases;
  var cumlativeDeaths;
  Chart ({ Key? key,required this.newCases ,
    required this.newDeaths,
    required this.cumlativeCases,
    required this.cumlativeDeaths }): super(key: key);
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  var confirmed = 16.0, death = 5.0, recoveries = 14.0;
  late List<Task> _chartData;
  late TooltipBehavior _toolTipBehaviour;
  @override
  void initState() {
    _chartData = getChartData();
    print(_chartData[0]);
    _toolTipBehaviour = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 300,
          height: 320,
          child: SfCircularChart(
            title: ChartTitle(text: ''),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: _toolTipBehaviour,
            series: <CircularSeries>[
              PieSeries<Task, String>(
                  dataSource: getChartData(),
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
  List<Task> getChartData() {
    final List<Task> chartData = [
      Task("Cases", widget.newCases.toDouble(), Colors.red),
      Task("Recoveries", (widget.newCases - widget.newDeaths) < 0 ? 0.0 : (widget.newCases - widget.newDeaths).toDouble(), Color.fromARGB(255, 57, 8, 156)),
      Task("Death", widget.newDeaths.toDouble(), Color.fromARGB(255, 2, 79, 50)),
    ];
    return chartData;
  }
}



class Task {
  final String name;
  final double value;
  final Color color;

  Task(this.name, this.value, this.color);
}
