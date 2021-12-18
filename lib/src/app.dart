import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_api_app/src/controllers/covid_statistics_controller.dart';

class App extends GetView<CovidStatisticsController> {
  const App({Key? key}) : super(key: key);

  Widget _infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            ": $value",
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("코로나 일별 현황"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          var info = controller.covidStatistic.value;
          return Column(
            children: [
              _infoWidget("기준일", info.stateDt ?? ''),
              _infoWidget("기준시간", info.stateTime ?? ''),
              _infoWidget("확진자 수", info.decideCnt ?? ''),
              _infoWidget("사망자 수", info.deathCnt ?? ''),
              _infoWidget("누적 검사 수", info.accExamCnt ?? ''),
              _infoWidget("누적 확진률", info.accDefRate ?? ''),
            ],
          );
        }),
      ),
    );
  }
}
