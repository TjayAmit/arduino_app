import 'package:arduino_app/Component/Widget/Graph/line_graph_pm.dart';
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
        leading: Container(),
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
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
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
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: SizedBox(
                                            width: Get.width,
                                            height: Get.height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Obx(
                                                  () => TextWidget(
                                                    title: controller
                                                        .co2Header.value,
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
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: SizedBox(
                                            width: Get.width,
                                            height: Get.height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Obx(
                                                  () => TextWidget(
                                                    title: controller
                                                        .tvocHeader.value,
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Container(
                                width: Get.width,
                                height: Get.height,
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextWidget(
                                      title: "AM Monitoring",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.9,
                                      height: 200,
                                      child: const LineGraph(),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Flexible(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Container(
                                width: Get.width,
                                height: Get.height,
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextWidget(
                                      title: "PM Monitoring",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.9,
                                      height: 200,
                                      child: const LineGraphPM(),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  height: 60,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.5,
                        spreadRadius: 0.5)
                  ]),
                  child: Container(
                    width: Get.width,
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Obx(
                          () => MaterialButton(
                            color: controller.co2Status.isTrue
                                ? Colors.pink
                                : Colors.grey,
                            minWidth: 120,
                            onPressed: () {
                              controller.co2Status.toggle();
                              if (controller.co2Status.isTrue) {
                                controller.sendcmd("poweron");
                              } else {
                                controller.sendcmd("poweroff");
                              }
                            },
                            child: TextWidget(
                              title:
                                  'Co2 1 ${controller.co2Status.isTrue ? "ON" : "OFF"}',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Obx(
                          () => MaterialButton(
                            color: controller.tvocStatus.isTrue
                                ? Colors.pink
                                : Colors.grey,
                            minWidth: 120,
                            onPressed: () {
                              controller.tvocStatus.toggle();
                              if (controller.tvocStatus.isTrue) {
                                controller.sendcmd("poweron 2");
                              } else {
                                controller.sendcmd("poweroff 2");
                              }
                            },
                            child: TextWidget(
                              title:
                                  'Tvoc ${controller.tvocStatus.isTrue ? "ON" : "OFF"}',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
