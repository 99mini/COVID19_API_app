import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_api_app/src/canvas/arrow_clip_path.dart';
import 'package:public_api_app/src/components/covid_statistics_viewer.dart';
import 'package:public_api_app/src/components/vaccine_statistics_viewer.dart';
import 'package:public_api_app/src/constant/color_constant.dart';
import 'package:public_api_app/src/components/covid_bar_chart.dart';
import 'package:public_api_app/src/controllers/covid_statistics_controller.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);
  double headerTopZone = 0;

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

  List<Widget> _background() {
    return [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              ColorConstant.deepBackgroundColor,
              ColorConstant.lightBackgroundColor,
            ],
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 40,
        left: -110,
        child: Container(
          child: Image.asset(
            "assets/images/covid.png",
            width: Get.width * 0.7,
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 10,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConstant.deepBackgroundColor,
            ),
            child: Obx(
              () => Text(
                controller.todayData.standardDayString,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 60,
        right: 40,
        child: Obx(
          () => CovidStatisticsViewer(
            title: "확진자",
            addedCount: controller.todayData.calcDecideCnt,
            totalCount: controller.todayData.decideCnt ?? 0,
            titleColor: Colors.white,
            subValueColor: Colors.white,
            upDown:
                controller.calculateUpDown(controller.todayData.calcDecideCnt),
          ),
        ),
      ),
    ];
  }

  Widget _todayStatistics() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CovidStatisticsViewer(
              title: "검사 중",
              addedCount: controller.todayData.calcExamCnt,
              totalCount: controller.todayData.accExamCnt ?? 0,
              upDown:
                  controller.calculateUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
          const SizedBox(
            height: 60,
            child: VerticalDivider(
              color: ColorConstant.lightGeryColor,
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              title: "사망자",
              addedCount: controller.todayData.calcDeathCnt,
              totalCount: controller.todayData.deathCnt ?? 0,
              upDown:
                  controller.calculateUpDown(controller.todayData.calcDeathCnt),
              dense: true,
            ),
          ),
          const SizedBox(
            height: 60,
            child: VerticalDivider(
              color: ColorConstant.lightGeryColor,
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              title: "접종완료",
              addedCount: controller.vaccineData[2].secondCnt ?? 0,
              totalCount: controller.vaccineData[2].secondCnt ?? 0,
              upDown: ArrowDirection.NONE,
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "확진자 추이",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Obx(
            () => controller.weekDays.isEmpty
                ? Container()
                : CovidBarChart(
                    covidDatas: controller.weekDays,
                    maxY: controller.maxDecideValue,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _reservationVaccine() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstant.primaryBlueColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/covid-vaccine-icon.png",
            width: 20,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          const Text(
            "잔여백신, 카톡으로 실시간 예약하기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _vaccineCurrentSituation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "백신 누적접종 현황",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: VaccineStatisticsViewer(
                  title: "1차 접종",
                  addedCount: controller.vaccineData[0].firstCnt ?? 0,
                  totalCount: controller.vaccineData[2].firstCnt ?? 0,
                  dense: true,
                ),
              ),
              const SizedBox(
                height: 60,
                child: VerticalDivider(
                  color: ColorConstant.lightGeryColor,
                ),
              ),
              Expanded(
                child: VaccineStatisticsViewer(
                  title: "접종 완료",
                  addedCount: controller.vaccineData[0].secondCnt ?? 0,
                  totalCount: controller.vaccineData[2].secondCnt ?? 0,
                  dense: true,
                ),
              ),
              const SizedBox(
                height: 60,
                child: VerticalDivider(
                  color: ColorConstant.lightGeryColor,
                ),
              ),
              Expanded(
                child: VaccineStatisticsViewer(
                  title: "추가접종",
                  addedCount: controller.vaccineData[0].thirdCnt ?? 0,
                  totalCount: controller.vaccineData[2].thirdCnt ?? 0,
                  subValueColor: Colors.black,
                  dense: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "코로나 일별 현황",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        ..._background(),
        Positioned(
          top: headerTopZone + 200,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    _todayStatistics(),
                    const SizedBox(height: 20),
                    _covidTrendsChart(),
                    const SizedBox(height: 20),
                    _reservationVaccine(),
                    const SizedBox(height: 20),
                    _vaccineCurrentSituation(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
