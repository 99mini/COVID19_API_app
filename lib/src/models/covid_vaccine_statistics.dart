import 'package:public_api_app/src/utils/data_utils.dart';
import 'package:public_api_app/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class CovidVaccineStatisticsModel {
  String? tpcd;
  double? firstCnt;
  double? secondCnt;
  double? thirdCnt;

  CovidVaccineStatisticsModel({
    this.tpcd,
    this.firstCnt,
    this.secondCnt,
    this.thirdCnt,
  });

  factory CovidVaccineStatisticsModel.empty() {
    return CovidVaccineStatisticsModel();
  }

  factory CovidVaccineStatisticsModel.fromXml(XmlElement xml) {
    return CovidVaccineStatisticsModel(
      tpcd: XmlUtils.searchResultForString(xml, 'tpcd'),
      firstCnt: XmlUtils.searchResultForDouble(xml, 'firstCnt'),
      secondCnt: XmlUtils.searchResultForDouble(xml, 'secondCnt'),
      thirdCnt: XmlUtils.searchResultForDouble(xml, 'thirdCnt'),
    );
  }
}
