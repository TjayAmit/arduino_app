import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:arduino_app/Controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class LineGraph extends GetView<MainController> {
  const LineGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Obx(
            () => SizedBox(
                child: LineChart(
              mainData(),
            )),
          ),
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
                  interval: 60)),
          topTitles: AxisTitles(
              axisNameWidget: const TextWidget(
                title: 'Co\u00B2 & Tvoc Monitoring',
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
        maxY: 550,
        lineBarsData: [
          LineChartBarData(
              spots: controller.listTvocGraph,
              isCurved: true,
              color: controller.tvocColor.value,
              barWidth: 5,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: true,
              )),
          LineChartBarData(
              spots: controller.listCo2Graph,
              isCurved: true,
              color: controller.co2Color.value,
              barWidth: 5,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: true,
              )),
        ]);
  }
}
