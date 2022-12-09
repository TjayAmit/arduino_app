import 'package:flutter/material.dart';
import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:get/get.dart';

class VocGauge extends StatelessWidget {
  const VocGauge({Key? key}) : super(key: key);

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
                  color: Colors.cyan,
                  value: 70,
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
                    title: '70 Voc',
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
