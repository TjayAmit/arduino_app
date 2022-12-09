import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineGraph extends StatelessWidget {
  const LineGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: SizedBox(
              child: LineChart(
            mainData(),
          )),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 42,
              getTitlesWidget: (value, meta) => TextWidget(
                title: '${meta.formattedValue} Hr',
                fontSize: 9,
              ),
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 42,
                  getTitlesWidget: (value, meta) => TextWidget(
                        title: '${meta.formattedValue} \u2109',
                        fontSize: 9,
                      ),
                  interval: 20)),
          topTitles: AxisTitles(
              axisNameWidget: const TextWidget(
                title: 'TEMPERATURE',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 8,
        minY: 0,
        maxY: 160,
        lineBarsData: [
          LineChartBarData(
              spots: const [
                FlSpot(0, 100),
                FlSpot(2, 70),
                FlSpot(4, 80),
                FlSpot(6, 50),
                FlSpot(8, 90),
              ],
              isCurved: true,
              color: Colors.cyan,
              barWidth: 5,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: true,
              ))
        ]);
  }
}
