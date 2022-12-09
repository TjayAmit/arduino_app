import 'package:flutter/material.dart';
import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:get/get.dart';

class CarbondioxideGauge extends StatelessWidget {
  const CarbondioxideGauge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width * 0.5,
        height: Get.width * 0.5,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  thicknessUnit: GaugeSizeUnit.factor,
                  cornerStyle: CornerStyle.bothCurve),
              showTicks: false,
              showLabels: false,
              minimum: 0,
              maximum: 150,
              interval: 10,
              pointers: [
                RangePointer(
                  color: Colors.orange,
                  value: 90,
                  onValueChanged: (_) {},
                  cornerStyle: CornerStyle.bothCurve,
                  onValueChangeEnd: (value) {},
                  onValueChangeStart: (value) {},
                  width: 0.2,
                  enableDragging: true,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
              annotations: const [
                GaugeAnnotation(
                  widget: TextWidget(
                    title: '90 Co\u00B2',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  positionFactor: 0.15,
                )
              ],
            )
          ],
        ));
  }
}
