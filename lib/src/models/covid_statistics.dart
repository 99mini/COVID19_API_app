import 'package:intl/intl.dart';
import 'package:public_api_app/src/utils/data_utils.dart';
import 'package:public_api_app/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accExamCnt;
  double? accDefRate;
  double? deathCnt;
  DateTime? stateDt;
  String? createDt;
  String? seq;
  String? stateTime;
  String? updateDt;
  double? decideCnt;
  double calcDecideCnt = 0;
  double calcExamCnt = 0;
  double calcDeathCnt = 0;

  Covid19StatisticsModel({
    this.accExamCnt,
    this.accDefRate,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.empty() {
    return Covid19StatisticsModel();
  }

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accExamCnt: XmlUtils.searchResultForDouble(xml, 'accExamCnt'),
      accDefRate: XmlUtils.searchResultForDouble(xml, 'accDefRate'),
      deathCnt: XmlUtils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultForDouble(xml, 'decideCnt'),
      createDt: XmlUtils.searchResultForString(xml, 'createDt'),
      seq: XmlUtils.searchResultForString(xml, 'seq'),
      stateDt: XmlUtils.searchResultForString(xml, 'stateDt') != ''
          ? DateTime.parse(XmlUtils.searchResultForString(xml, 'stateDt'))
          : null,
      stateTime: XmlUtils.searchResultForString(xml, 'stateTime'),
      updateDt: XmlUtils.searchResultForString(xml, 'updateDt'),
    );
  }

  void updateCalcAboutYesterday(Covid19StatisticsModel yesterdayData) {
    _updateCalcDeathCnt(yesterdayData.deathCnt!);
    _updateCalcExamCnt(yesterdayData.accExamCnt!);
    _updateCalcDecideCnt(yesterdayData.decideCnt!);
  }

  void _updateCalcDecideCnt(double before) {
    calcDecideCnt = decideCnt! - before;
  }

  void _updateCalcExamCnt(double before) {
    calcExamCnt = accExamCnt! - before;
  }

  void _updateCalcDeathCnt(double before) {
    calcDeathCnt = deathCnt! - before;
  }

  String get standardDayString => stateDt == null
      ? ''
      : "${DataUtils.simpleDateFormat(stateDt!)} $stateTime 기준";
}
