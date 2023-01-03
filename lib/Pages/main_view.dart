import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:arduino_app/Controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arduino_app/Component/Widget/Co2Gauge/carbondioxide_gauge.dart';
import 'package:arduino_app/Component/Widget/VocGauge/voc_gauge.dart';
import 'package:arduino_app/Component/Widget/Graph/line_graph.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          title: 'Arduino App',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: Colors.cyan,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: SizedBox(
                                  width: Get.width,
                                  height: Get.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(
                                        () => TextWidget(
                                          title: controller.co2Header.value,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const CarbondioxideGauge(),
                                    ],
                                  ),
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: SizedBox(
                                  width: Get.width,
                                  height: Get.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(
                                        () => TextWidget(
                                          title: controller.tvocHeader.value,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const VocGauge(),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
              Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.9,
                          height: 200,
                          child: const LineGraph(),
                        )
                      ],
                    ),
                  )),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        color: Colors.pink,
                        minWidth: 120,
                        onPressed: () {
                          controller.sendcmd("poweroff");
                        },
                        child: const TextWidget(
                          title: 'RELAY 1 ON',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      MaterialButton(
                        color: Colors.grey,
                        minWidth: 120,
                        onPressed: () {
                          controller.sendcmd("poweron");
                        },
                        child: const TextWidget(
                          title: 'RELAY 2 OFF',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
