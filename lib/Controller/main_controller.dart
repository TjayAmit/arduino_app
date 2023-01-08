import 'dart:developer';

import 'package:arduino_app/Controller/notification_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
  IOWebSocketChannel? socket;

  RxString logsDetails = "".obs;

  RxBool connected = false.obs;
  RxBool ledstatus = true.obs;

  RxString mssg = "".obs;
  RxDouble tvoc = 0.0.obs;
  RxDouble co2 = 0.0.obs;

  Rxn<Color> co2Color = Rxn<Color>(Colors.green).obs();
  Rxn<Color> tvocColor = Rxn<Color>(Colors.green).obs();

  RxBool tvocStatus = false.obs;
  RxBool co2Status = false.obs;
  
  RxInt test = 0.obs;

  RxString co2Header = "Good".obs;
  RxString tvocHeader = "Good".obs;

  RxList<FlSpot> listCo2Graph = RxList<FlSpot>([]).obs();
  RxList<FlSpot> listCo2GraphPM = RxList<FlSpot>([]).obs();

  RxList<FlSpot> listTvocGraph = RxList<FlSpot>([]).obs();
  RxList<FlSpot> listTvocGraphPM = RxList<FlSpot>([]).obs();

  NotificationController? notificationController;

  Rxn<FlSpot> am1 = Rxn<FlSpot>(const FlSpot(1, 100)).obs();
  Rxn<FlSpot> am2 = Rxn<FlSpot>(const FlSpot(2, 100)).obs();
  Rxn<FlSpot> am3 = Rxn<FlSpot>(const FlSpot(3, 100)).obs();
  Rxn<FlSpot> am4 = Rxn<FlSpot>(const FlSpot(4, 100)).obs();
  Rxn<FlSpot> am5 = Rxn<FlSpot>(const FlSpot(5, 100)).obs();
  Rxn<FlSpot> am6 = Rxn<FlSpot>(const FlSpot(6, 100)).obs();
  Rxn<FlSpot> am7 = Rxn<FlSpot>(const FlSpot(7, 100)).obs();
  Rxn<FlSpot> am8 = Rxn<FlSpot>(const FlSpot(8, 100)).obs();
  Rxn<FlSpot> am9 = Rxn<FlSpot>(const FlSpot(9, 100)).obs();
  Rxn<FlSpot> am10 = Rxn<FlSpot>(const FlSpot(10, 100)).obs();
  Rxn<FlSpot> am11 = Rxn<FlSpot>(const FlSpot(11, 100)).obs();
  Rxn<FlSpot> am12 = Rxn<FlSpot>(const FlSpot(12, 100)).obs();

  Rxn<FlSpot> am1Tvoc = Rxn<FlSpot>(const FlSpot(1, 100)).obs();
  Rxn<FlSpot> am2Tvoc = Rxn<FlSpot>(const FlSpot(2, 100)).obs();
  Rxn<FlSpot> am3Tvoc = Rxn<FlSpot>(const FlSpot(3, 100)).obs();
  Rxn<FlSpot> am4Tvoc = Rxn<FlSpot>(const FlSpot(4, 100)).obs();
  Rxn<FlSpot> am5Tvoc = Rxn<FlSpot>(const FlSpot(5, 100)).obs();
  Rxn<FlSpot> am6Tvoc = Rxn<FlSpot>(const FlSpot(6, 100)).obs();
  Rxn<FlSpot> am7Tvoc = Rxn<FlSpot>(const FlSpot(7, 100)).obs();
  Rxn<FlSpot> am8Tvoc = Rxn<FlSpot>(const FlSpot(8, 100)).obs();
  Rxn<FlSpot> am9Tvoc = Rxn<FlSpot>(const FlSpot(9, 100)).obs();
  Rxn<FlSpot> am10Tvoc = Rxn<FlSpot>(const FlSpot(10, 100)).obs();
  Rxn<FlSpot> am11Tvoc = Rxn<FlSpot>(const FlSpot(11, 100)).obs();
  Rxn<FlSpot> am12Tvoc = Rxn<FlSpot>(const FlSpot(12, 100)).obs();

  Rxn<FlSpot> pm1 = Rxn<FlSpot>(const FlSpot(1, 100)).obs();
  Rxn<FlSpot> pm2 = Rxn<FlSpot>(const FlSpot(2, 100)).obs();
  Rxn<FlSpot> pm3 = Rxn<FlSpot>(const FlSpot(3, 100)).obs();
  Rxn<FlSpot> pm4 = Rxn<FlSpot>(const FlSpot(4, 100)).obs();
  Rxn<FlSpot> pm5 = Rxn<FlSpot>(const FlSpot(5, 100)).obs();
  Rxn<FlSpot> pm6 = Rxn<FlSpot>(const FlSpot(6, 100)).obs();
  Rxn<FlSpot> pm7 = Rxn<FlSpot>(const FlSpot(7, 100)).obs();
  Rxn<FlSpot> pm8 = Rxn<FlSpot>(const FlSpot(8, 100)).obs();
  Rxn<FlSpot> pm9 = Rxn<FlSpot>(const FlSpot(9, 100)).obs();
  Rxn<FlSpot> pm10 = Rxn<FlSpot>(const FlSpot(10, 100)).obs();
  Rxn<FlSpot> pm11 = Rxn<FlSpot>(const FlSpot(11, 100)).obs();
  Rxn<FlSpot> pm12 = Rxn<FlSpot>(const FlSpot(12, 100)).obs();

  Rxn<FlSpot> pm1Tvoc = Rxn<FlSpot>(const FlSpot(1, 100)).obs();
  Rxn<FlSpot> pm2Tvoc = Rxn<FlSpot>(const FlSpot(2, 100)).obs();
  Rxn<FlSpot> pm3Tvoc = Rxn<FlSpot>(const FlSpot(3, 100)).obs();
  Rxn<FlSpot> pm4Tvoc = Rxn<FlSpot>(const FlSpot(4, 100)).obs();
  Rxn<FlSpot> pm5Tvoc = Rxn<FlSpot>(const FlSpot(5, 100)).obs();
  Rxn<FlSpot> pm6Tvoc = Rxn<FlSpot>(const FlSpot(6, 100)).obs();
  Rxn<FlSpot> pm7Tvoc = Rxn<FlSpot>(const FlSpot(7, 100)).obs();
  Rxn<FlSpot> pm8Tvoc = Rxn<FlSpot>(const FlSpot(8, 100)).obs();
  Rxn<FlSpot> pm9Tvoc = Rxn<FlSpot>(const FlSpot(9, 100)).obs();
  Rxn<FlSpot> pm10Tvoc = Rxn<FlSpot>(const FlSpot(10, 100)).obs();
  Rxn<FlSpot> pm11Tvoc = Rxn<FlSpot>(const FlSpot(11, 100)).obs();
  Rxn<FlSpot> pm12Tvoc = Rxn<FlSpot>(const FlSpot(12, 100)).obs();

  @override
  void onInit() {
    super.onInit();
    notificationController = Get.put(NotificationController());
    initializeSocket();
    mssg.listen((p0) {
      var data = p0.trim().split("|");
      if(test.value > 20){
        logsDetails.value = '';
      }
      double val = double.parse(data[0]);
      double val1 = double.parse(data[1]);
      logsDetails.value += "\n$p0";
      test.value++;

      // if (val < 9000) {
      //   tvoc.value = val;
      // }

      // if (val1 < 2100) {
      //   co2.value = val1;
      // }

      // print(p0.trim());
    });


    // tvoc.listen((p0) {
    //   if (p0 < 9000) {
    //     if (p0 > 661) {
    //       notify("Warning TVoc is in High Level", "Tvoc status: $p0");
    //     }
    //     checkChangesOfTvoc();
    //     initLineGraphForTvoc();
    //     initLineGraphForTvocPM();
    //   }
    // });

    // co2.listen((p0) {
    //   if (p0 < 2100) {
    //     if (p0 > 1100) {
    //       notify("Warning Co\u00B2 is in High Level", "Co\u00B2 status: $p0");
    //     }
    //     checkChangesOfCarbonDioxide();
    //     initLineGraphForCo2();
    //     initLineGraphForCo2PM();
    //   }
    // });
  }

  void initLineGraphForTvoc() {
    try {
      int h = DateTime.now().hour;

      if (h > 12) {
        return;
      } else {
        switch (h) {
          case 1:
            am1Tvoc.value = FlSpot(1, tvoc.value);
            break;
          case 2:
            am2Tvoc.value = FlSpot(2, tvoc.value);
            break;
          case 3:
            am3Tvoc.value = FlSpot(3, tvoc.value);
            break;
          case 4:
            am4Tvoc.value = FlSpot(4, tvoc.value);
            break;
          case 5:
            am5Tvoc.value = FlSpot(5, tvoc.value);
            break;
          case 6:
            am6Tvoc.value = FlSpot(6, tvoc.value);
            break;
          case 7:
            am7Tvoc.value = FlSpot(7, tvoc.value);
            break;
          case 8:
            am8Tvoc.value = FlSpot(8, tvoc.value);
            break;
          case 9:
            am9Tvoc.value = FlSpot(9, tvoc.value);
            break;
          case 10:
            am10Tvoc.value = FlSpot(10, tvoc.value);
            break;
          case 11:
            am11Tvoc.value = FlSpot(11, tvoc.value);
            break;
          default:
            am12Tvoc.value = FlSpot(12, tvoc.value);
            break;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void initLineGraphForCo2() {
    try {
      int h = DateTime.now().hour;

      if (h > 12) {
        return;
      } else {
        switch (h) {
          case 1:
            am1.value = FlSpot(1, co2.value);
            break;
          case 2:
            am2.value = FlSpot(2, co2.value);
            break;
          case 3:
            am3.value = FlSpot(3, co2.value);
            break;
          case 4:
            am4.value = FlSpot(4, co2.value);
            break;
          case 5:
            am5.value = FlSpot(5, co2.value);
            break;
          case 6:
            am6.value = FlSpot(6, co2.value);
            break;
          case 7:
            am7.value = FlSpot(7, co2.value);
            break;
          case 8:
            am8.value = FlSpot(8, co2.value);
            break;
          case 9:
            am9.value = FlSpot(9, co2.value);
            break;
          case 10:
            am10.value = FlSpot(10, co2.value);
            break;
          case 11:
            am11.value = FlSpot(11, co2.value);
            break;
          default:
            am12.value = FlSpot(12, co2.value);
            break;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void initLineGraphForTvocPM() {
    try {
      int h = DateTime.now().hour;

      if (h < 12) {
        return;
      } else {
        h = h - 12;
        switch (h) {
          case 1:
            pm1Tvoc.value = FlSpot(1, tvoc.value);
            break;
          case 2:
            pm2Tvoc.value = FlSpot(2, tvoc.value);
            break;
          case 3:
            pm3Tvoc.value = FlSpot(3, tvoc.value);
            break;
          case 4:
            pm4Tvoc.value = FlSpot(4, tvoc.value);
            break;
          case 5:
            pm5Tvoc.value = FlSpot(5, tvoc.value);
            break;
          case 6:
            pm6Tvoc.value = FlSpot(6, tvoc.value);
            break;
          case 7:
            pm7Tvoc.value = FlSpot(7, tvoc.value);
            break;
          case 8:
            pm8Tvoc.value = FlSpot(8, tvoc.value);
            break;
          case 9:
            pm9Tvoc.value = FlSpot(9, tvoc.value);
            break;
          case 10:
            pm10Tvoc.value = FlSpot(10, tvoc.value);
            break;
          case 11:
            pm11Tvoc.value = FlSpot(11, tvoc.value);
            break;
          default:
            pm12Tvoc.value = FlSpot(12, tvoc.value);
            break;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void initLineGraphForCo2PM() {
    try {
      int h = DateTime.now().hour;

      if (h < 12) {
        return;
      } else {
        h = h - 12;
        switch (h) {
          case 1:
            pm1.value = FlSpot(1, co2.value);
            break;
          case 2:
            pm2.value = FlSpot(2, co2.value);
            break;
          case 3:
            pm3.value = FlSpot(3, co2.value);
            break;
          case 4:
            pm4.value = FlSpot(4, co2.value);
            break;
          case 5:
            pm5.value = FlSpot(5, co2.value);
            break;
          case 6:
            pm6.value = FlSpot(6, co2.value);
            break;
          case 7:
            pm7.value = FlSpot(7, co2.value);
            break;
          case 8:
            pm8.value = FlSpot(8, co2.value);
            break;
          case 9:
            pm9.value = FlSpot(9, co2.value);
            break;
          case 10:
            pm10.value = FlSpot(10, co2.value);
            break;
          case 11:
            pm11.value = FlSpot(11, co2.value);
            break;
          default:
            pm12.value = FlSpot(12, co2.value);
            break;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void notify(String header, String description) {
    int h = DateTime.now().hour;
    if (header.toLowerCase().contains('tvoc')) {
      h = 5;
    }
    int notificationIndex = h;

    notificationController!
        .showNotification(notificationIndex, header, description, "test");
  }

  void checkChangesOfTvoc() {
    double p0 = tvoc.value;

    if (p0 > 1431) {
      tvocColor.value = Colors.red;
      tvocHeader.value = 'Very High';
    }
    if (p0 > 661 && p0 < 1430) {
      tvocColor.value = Colors.deepOrangeAccent;
      tvocHeader.value = 'High';
    }
    if (p0 > 221 && p0 < 660) {
      tvocColor.value = Colors.orange;
      tvocHeader.value = 'Moderate';
    }
    if (p0 > 0 && p0 < 200) {
      tvocColor.value = Colors.green;
      tvocHeader.value = 'Good';
    }
    tvocColor.refresh();
  }

  void checkChangesOfCarbonDioxide() {
    double p0 = co2.value;

    if (p0 > 2001) {
      co2Color.value = Colors.red;
      co2Header.value = "BAD Air Quality";
    }
    if (p0 > 1600 && p0 < 2000) {
      co2Color.value = Colors.deepOrangeAccent;
      co2Header.value = "Heavily contaminated";
    }
    if (p0 > 1100 && p0 < 1500) {
      co2Color.value = Colors.orange;
      co2Header.value = "Ventilation Recommended";
    }
    if (p0 > 601 && p0 < 1000) {
      co2Color.value = Colors.red;
      co2Header.value = "Good Air Quality";
    }
    if (p0 > 0 && p0 < 600) {
      co2Color.value = Colors.green;
      co2Header.value = "EXCELLENT Air Quality";
    }
    co2Color.refresh();
  }

  void initializeSocket() async {
    socketInitializing("Starting websocket");
  }

  void socketInitializing(String status) {
    print(status);
    socket = IOWebSocketChannel.connect('ws://192.168.13.133:432');
    streamWebSocket();
  }

  void streamWebSocket() {
    try {
      socket!.stream.listen(
        (message) {
          try {
            mssg.value = message.toString();
          } catch (_) {
            print('ignoring proccess');
          }
          connected.value = true;
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
        },
        onError: (error) {
          connected.value = false;
          Future.delayed(const Duration(milliseconds: 1000),
              () => socketInitializing("Timeout Restarting websocket"));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendcmd(String cmd) async {
    if (connected.isTrue) {
      if (cmd != "poweron" &&
          cmd != "poweroff" &&
          cmd != "poweron 2" &&
          cmd != "poweroff 2") {
        print("Send the valid command");
      } else {
        socket!.sink.add(cmd); //sending Command to NodeMCU
      }
    } else {
      initializeSocket();
      print("Websocket is not connected.");
    }
  }
}
