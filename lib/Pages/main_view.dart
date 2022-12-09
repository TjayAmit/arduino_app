import 'package:arduino_app/Component/Widget/Text/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arduino_app/Component/Widget/Co2Gauge/carbondioxide_gauge.dart';
import 'package:arduino_app/Component/Widget/VocGauge/voc_gauge.dart';
import 'package:arduino_app/Component/Widget/Graph/line_graph.dart';

class MainView extends StatelessWidget {
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
                                    children: const [
                                      TextWidget(
                                        title: 'INSIDE',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      CarbondioxideGauge(),
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
                                    children: const [
                                      TextWidget(
                                        title: 'OUTSIDE',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      VocGauge(),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: Get.width,
                                height: Get.height,
                                color: Colors.cyan[200],
                                child: Stack(
                                  children: const [
                                    Positioned.fill(
                                        top: 20,
                                        child: Center(
                                          child: TextWidget(
                                            title: '27%',
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        child: TextWidget(
                                          title: 'BATTERY',
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              ),
                            )),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: Get.width,
                                height: Get.height,
                                color: Colors.cyan[200],
                                child: Stack(
                                  children: const [
                                    Positioned.fill(
                                        top: 20,
                                        child: Center(
                                          child: TextWidget(
                                            title: '55%',
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                                    Positioned(
                                        top: 10,
                                        left: 10,
                                        child: TextWidget(
                                          title: 'BATTERY',
                                          fontSize: 12,
                                        ))
                                  ],
                                ),
                              ),
                            )),
                      ],
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
                          onPressed: () {},
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
                          onPressed: () {},
                          child: const TextWidget(
                            title: 'RELAY 2 OFF',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
