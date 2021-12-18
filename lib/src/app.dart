import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_api_app/src/canvas/arrow_clip_path.dart';
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
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff5499a8),
                Color(0xff3c727c),
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
                color: Color(0xff2e5963),
              ),
              child: Text(
                "12:18 00:00 기준",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
            top: headerTopZone + 60,
            right: 40,
            child: Column(
              children: [
                Text(
                  "확진자",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Row(
                  children: [
                    ClipPath(
                      clipper: ArrowClipPath(),
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Color(0xffda5959),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "1625",
                      style: TextStyle(
                          color: Color(0xffda5959),
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "187312",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ))
      ]),
    );
  }
}
