// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:public_api_app/main.dart';
import 'package:public_api_app/src/models/covid_vaccine_statistics.dart';
import 'package:xml/xml.dart';

void main() {
  test('코로나 전체 통계', () {
    fetchCovidVaccineStatistics();
  });
}

void fetchCovidVaccineStatistics() async {
  print("start");
  var response =
      await Dio().get("https://nip.kdca.go.kr/irgd/cov19stats.do?list=all");
  print("end");
  print(response.data);
}
