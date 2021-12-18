import 'package:dio/dio.dart';
import 'package:public_api_app/src/models/covid_statistics.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  final bookshelfXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accExamCnt>18539009</accExamCnt>
                <createDt>2021-12-18 09:10:13.455</createDt>
                <deathCnt>4644</deathCnt>
                <decideCnt>558864</decideCnt>
                <seq>731</seq>
                <stateDt>20211218</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
            <item>
                <accExamCnt>18460563</accExamCnt>
                <createDt>2021-12-17 09:07:19.97</createDt>
                <deathCnt>4591</deathCnt>
                <decideCnt>551550</decideCnt>
                <seq>730</seq>
                <stateDt>20211217</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-18 09:10:22.783</updateDt>
            </item>
            <item>
                <accExamCnt>18381569</accExamCnt>
                <createDt>2021-12-16 09:09:11.111</createDt>
                <deathCnt>4518</deathCnt>
                <decideCnt>544116</decideCnt>
                <seq>729</seq>
                <stateDt>20211216</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-17 09:08:56.596</updateDt>
            </item>
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
            <item>
                <accExamCnt>18140572</accExamCnt>
                <createDt>2021-12-13 09:00:10.891</createDt>
                <deathCnt>4292</deathCnt>
                <decideCnt>523077</decideCnt>
                <seq>726</seq>
                <stateDt>20211213</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-17 09:08:32.95</updateDt>
            </item>
            <item>
                <accExamCnt>18084589</accExamCnt>
                <createDt>2021-12-12 08:35:19.089</createDt>
                <deathCnt>4252</deathCnt>
                <decideCnt>517260</decideCnt>
                <seq>725</seq>
                <stateDt>20211212</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-17 09:08:23.25</updateDt>
            </item>
            <item>
                <accExamCnt>17950721</accExamCnt>
                <createDt>2021-12-10 09:04:53.786</createDt>
                <deathCnt>4130</deathCnt>
                <decideCnt>503601</decideCnt>
                <seq>723</seq>
                <stateDt>20211210</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2021-12-17 09:08:03.447</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>8</totalCount>
    </body>
</response>''';

  CovidStatisticsRepository() {
    _dio = Dio(
      BaseOptions(baseUrl: "http://openapi.data.go.kr", queryParameters: {
        "ServiceKey":
            "SybIVL6/ZSkWIHbjbD1bmCvXuPFY5a7g52aSX8I07ofzCkU4VNmIeZGLNcB3UnReXfKifrt6OxXOE2l73SrUPg=="
      }),
    );
  }

  Future<Covid19StatisticsModel> fetchCovidStatistics() async{
    // var response = await _dio.get("/openapi/service/rest/Covid19/getCovid19InfStateJson");

    // final document = XmlDocument.parse(response.data);
    final document = XmlDocument.parse(bookshelfXml);
    final results = document.findAllElements('item');
    if (results.isNotEmpty){
      return Covid19StatisticsModel.fromXml(results.first);
    }else{
      return Future.value(null);
    }
  }
}
