import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:predi_v2/shared/models/enums/data_type_enum.dart';

class AppLineChart extends StatelessWidget {
  final List<dynamic> dataList;
  final DataTypeEnum dataType;
  const AppLineChart(
      {super.key, required this.dataList, required this.dataType});

  @override
  Widget build(BuildContext context) {
    final barData = _getBarData();
    return LineChart(
      LineChartData(
        minY: dataType.minValue,
        maxY: dataType.maxValue,
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: MediaQuery.of(context).size.width * .15,
              interval: ((dataType.maxValue! - dataType.minValue!) / 7),
              showTitles: true,
              /*getTitlesWidget: (value, meta) {
                return Text(
                    '${value.toStringAsFixed(1)} ${dataType.measurementUnit}');
              },*/
            ),
          ),
        ),
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: ((dataType.maxValue! - dataType.minValue!) / 7),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Theme.of(context).colorScheme.primary,
              tooltipRoundedRadius: 16.0,
              fitInsideHorizontally: true,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  return LineTooltipItem(
                      '${touchedSpot.y.toStringAsFixed(2)} ${dataType.measurementUnit}',
                      TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold));
                }).toList();
              }),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(barData.length,
                (index) => FlSpot(index.toDouble(), barData[index])),
            isCurved: false,
            color: Theme.of(context).colorScheme.primary,
            dotData: FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withAlpha(150)),
          )
        ],
      ),
    );
  }

  List<double> _getBarData() {
    var barData = dataList.reversed.map((data) {
      double value = _getValue(data);
      if (!value.isNaN) {
        return value;
      } else {
        value = 0.0;
        return value;
      }
    }).toList();

    return barData.sublist(barData.length < 5 ? 0 : barData.length - 5);
  }

  double _getValue(data) {
    switch (dataType) {
      case DataTypeEnum.glycatedHemoglobin:
        return data.glycatedHemoglobin;
      case DataTypeEnum.fastingGlucose:
        return data.fastingGlucose;
      case DataTypeEnum.glucose75g:
        return data.glucose75g;
      case DataTypeEnum.weight:
        return data.weight;
      case DataTypeEnum.circumference:
        return data.circumference;
      default:
        return 0.00;
    }
  }
}
