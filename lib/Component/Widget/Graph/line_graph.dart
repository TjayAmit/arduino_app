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
                title: "${meta.formattedValue} AM",
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
                        title: meta.formattedValue,
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
                controller.am1.value!,
                controller.am2.value!,
                controller.am3.value!,
                controller.am4.value!,
                controller.am5.value!,
                controller.am6.value!,
                controller.am7.value!,
                controller.am8.value!,
                controller.am9.value!,
                controller.am10.value!,
                controller.am11.value!,
                controller.am12.value!,
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
                controller.am1Tvoc.value!,
                controller.am2Tvoc.value!,
                controller.am3Tvoc.value!,
                controller.am4Tvoc.value!,
                controller.am5Tvoc.value!,
                controller.am6Tvoc.value!,
                controller.am7Tvoc.value!,
                controller.am8Tvoc.value!,
                controller.am9Tvoc.value!,
                controller.am10Tvoc.value!,
                controller.am11Tvoc.value!,
                controller.am12Tvoc.value!,
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
