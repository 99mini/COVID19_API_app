// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:public_api_app/main.dart';
import 'package:xml/xml.dart';

void main() {
  const bookshelfXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accExamCnt>18298675</accExamCnt>
                <createDt>2021-12-15 09:02:08.087</createDt>
                <deathCnt>4456</deathCnt>
                <decideCnt>536494</decideCnt>
                <seq>728</seq>
                <stateDt>20211215</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-17 09:08:47.754</updateDt>
            </item>
            <item>
                <accExamCnt>18224740</accExamCnt>
                <createDt>2021-12-14 09:05:48.519</createDt>
                <deathCnt>4386</deathCnt>
                <decideCnt>528644</decideCnt>
                <seq>727</seq>
                <stateDt>20211214</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-17 09:08:40.78</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>2</totalCount>
    </body>
</response>''';

  test('코로나 전체 통계', (){
    // final document = XmlDocument.parse(bookshelfXml);
    // final items = document.findAllElements('item');
    // var covid19Statics = <Covid19StatisticsModel>[];
    // items.forEach((node){
    //   covid19Statics.add(Covid19StatisticsModel.fromXml(node));
    // });
    //   covid19Statics.forEach((element) {
    //   print('${element.stateDt} : ${element.decideCnt}');
    // });
  });



}

class Covid19StatisticsModel{
  String? accExamCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accExamCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.fromXml(XmlElement xml){
    return Covid19StatisticsModel(
        accExamCnt : XmlUtils.searchResult(xml, 'accExamCnt'),
        createDt : XmlUtils.searchResult(xml, 'createDt'),
        deathCnt : XmlUtils.searchResult(xml, 'deathCnt'),
        decideCnt : XmlUtils.searchResult(xml, 'decideCnt'),
        seq : XmlUtils.searchResult(xml, 'seq'),
        stateDt : XmlUtils.searchResult(xml, 'stateDt'),
        stateTime : XmlUtils.searchResult(xml, 'stateTime'),
        updateDt : XmlUtils.searchResult(xml, 'updateDt'),
    );
  }
}

class XmlUtils{
  static String searchResult(XmlElement xml, String key){
    return xml.findAllElements(key).map((e)=>e.text).isEmpty ? "" : xml.findAllElements(key).map((e)=>e.text).first;
  }
}