import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:public_api_app/src/constant/color_constant.dart';
import 'package:public_api_app/src/models/covid_statistics.dart';
import 'package:public_api_app/src/utils/data_utils.dart';

class CovidBarChart extends StatelessWidget {
  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;
  const CovidBarChart({Key? key, required this.maxY, required this.covidDatas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY * 1.5,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 8,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.y.round().toString(),
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) =>
                const TextStyle(color: Colors.black, fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              return DataUtils.simpleDateFormat(
                  covidDatas[value.toInt()].stateDt!);
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: this.covidDatas.map<BarChartGroupData>((covidData) {
          return BarChartGroupData(
            x: x++,
            barRods: [
              BarChartRodData(y: covidData.calcDecideCnt, colors: [
                ColorConstant.primaryDeepRedColor,
                ColorConstant.primaryRedColor,
              ])
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
      ),
    );
  }
}
