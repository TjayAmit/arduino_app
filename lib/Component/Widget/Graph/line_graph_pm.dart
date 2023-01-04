import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:arduino_app/Controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class LineGraphPM extends GetView<MainController> {
  const LineGraphPM({Key? key}) : super(key: key);

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
                title: "${meta.formattedValue} PM",
                fontSize: 7,
              ),
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) => TextWidget(
                        title: '${meta.formattedValue} ',
                        fontSize: 9,
                      ),
                  interval: 1000)),
          topTitles: AxisTitles(
              axisNameWidget: const TextWidget(
                title: '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 1,
        maxX: 12,
        minY: 0,
        maxY: 9000,
        lineBarsData: [
          LineChartBarData(
              spots: [
                controller.pm1.value!,
                controller.pm2.value!,
                controller.pm3.value!,
                controller.pm4.value!,
                controller.pm5.value!,
                controller.pm6.value!,
                controller.pm7.value!,
                controller.pm8.value!,
                controller.pm9.value!,
                controller.pm10.value!,
                controller.pm11.value!,
                controller.pm12.value!,
              ],
              isCurved: true,
              color: controller.tvocColor.value,
              barWidth: 5,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: true,
              )),
          LineChartBarData(
              spots: [
                controller.pm1Tvoc.value!,
                controller.pm2Tvoc.value!,
                controller.pm3Tvoc.value!,
                controller.pm4Tvoc.value!,
                controller.pm5Tvoc.value!,
                controller.pm6Tvoc.value!,
                controller.pm7Tvoc.value!,
                controller.pm8Tvoc.value!,
                controller.pm9Tvoc.value!,
                controller.pm10Tvoc.value!,
                controller.pm11Tvoc.value!,
                controller.pm12Tvoc.value!,
              ],
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
