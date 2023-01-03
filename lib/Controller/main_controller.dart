import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

class MainController extends GetxController {
  IOWebSocketChannel? socket;

  RxBool connected = false.obs;
  RxBool ledstatus = false.obs;

  RxString mssg = "".obs;
  RxDouble tvoc = 0.0.obs;
  RxDouble co2 = 0.0.obs;

  Rxn<Color> co2Color = Rxn<Color>(Colors.green).obs();
  Rxn<Color> tvocColor = Rxn<Color>(Colors.green).obs();

  RxString co2Header = "Good".obs;
  RxString tvocHeader = "Good".obs;

  RxList<double> listCo2 = RxList<double>([]).obs();
  RxList<FlSpot> listCo2Graph = RxList<FlSpot>([]).obs();

  RxList<double> listTvoc = RxList<double>([]).obs();
  RxList<FlSpot> listTvocGraph = RxList<FlSpot>([]).obs();

  @override
  void onInit() {
    super.onInit();
    initializeSocket();
    mssg.listen((p0) {
      var data = p0.trim().split("|");
      tvoc.value = double.parse(data[0]);
      co2.value = double.parse(data[1]);
      listCo2.add(co2.value);
      listTvoc.add(tvoc.value);
      checkChangesOfCarbonDioxide();
      checkChangesOfTvoc();
      initLineGraphForTvoc();
      initLineGraphForCo2();
      print(p0.trim());
    });
  }

  void initLineGraphForTvoc() {
    try {
      List<FlSpot> list = [];
      int index = listTvoc.length - 1 > 8 ? listTvoc.length : 9;
      double x = 0;

      for (var i = index; i > index - 10; i++) {
        try {
          list.add(FlSpot(x, listTvoc[index]));
        } catch (_) {
          list.add(FlSpot(x, 0));
        }
        x++;
      }

      listTvocGraph.value = list;
      listTvocGraph.refresh();
    } catch (e) {
      print(e.toString());
    }
  }

  void initLineGraphForCo2() {
    try {
      List<FlSpot> list = [];
      int index = listCo2.length - 1 > 8 ? listCo2.length : 9;
      double x = 0;

      for (var i = index; i > index - 10; i++) {
        try {
          list.add(FlSpot(x, listCo2[index]));
        } catch (_) {
          list.add(FlSpot(x, 0));
        }
        x++;
      }

      listCo2Graph.value = list;
      listCo2Graph.refresh();
    } catch (e) {
      print(e.toString());
    }
  }

  void checkChangesOfTvoc() {
    double p0 = tvoc.value;

    if (p0 > 301 && p0 < 550) {
      tvocColor.value = Colors.deepPurple;
      tvocHeader.value = 'Very High';
    }
    if (p0 > 201 && p0 < 300) {
      tvocColor.value = Colors.deepPurpleAccent;
      tvocHeader.value = 'Very High';
    }
    if (p0 > 151 && p0 < 200) {
      tvocColor.value = Colors.red;
      tvocHeader.value = 'Very High';
    }
    if (p0 > 101 && p0 < 150) {
      tvocColor.value = Colors.deepOrangeAccent;
      tvocHeader.value = 'High';
    }
    if (p0 > 51 && p0 < 100) {
      tvocColor.value = Colors.orange;
      tvocHeader.value = 'Moderate';
    }
    if (p0 > 0 && p0 < 50) {
      tvocColor.value = Colors.green;
      tvocHeader.value = 'Good';
    }
    tvocColor.refresh();
  }

  void checkChangesOfCarbonDioxide() {
    double p0 = co2.value;

    if (p0 > 2001 && p0 < 2100) {
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
    try {
      socket = IOWebSocketChannel.connect('ws://192.168.13.133:432');
      connected.value = true;
      streamWebSocket();
    } catch (e) {
      print(e.toString());
    }
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
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          connected.value = false;
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendcmd(String cmd) async {
    if (connected.isTrue) {
      if (ledstatus.value == false && cmd != "poweron" && cmd != "poweroff") {
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
