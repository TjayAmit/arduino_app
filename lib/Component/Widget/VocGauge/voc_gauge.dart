import 'package:arduino_app/Controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:get/get.dart';

class VocGauge extends GetView<MainController> {
  const VocGauge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
          width: Get.width * 0.5,
          height: Get.width * 0.4,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                axisLineStyle: const AxisLineStyle(
                    thickness: 0.2,
                    thicknessUnit: GaugeSizeUnit.factor,
                    cornerStyle: CornerStyle.bothCurve),
                showTicks: false,
                showLabels: false,
                minimum: 1,
                maximum: 9000,
                interval: 10,
                pointers: [
                  RangePointer(
                    color: controller.tvocColor.value,
                    value: controller.tvoc.value,
                    onValueChanged: (_) {},
                    cornerStyle: CornerStyle.bothCurve,
                    onValueChangeEnd: (value) {},
                    onValueChangeStart: (value) {},
                    width: 0.2,
                    enableDragging: true,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: TextWidget(
                      title:
                          '${controller.tvoc.value.truncate().toString()} Voc',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    positionFactor: 0.15,
                  )
                ],
              )
            ],
          )),
    );
  }
}
