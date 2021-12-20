import 'package:dio/dio.dart';
import 'package:public_api_app/src/models/covid_statistics.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;
  CovidStatisticsRepository() {
    _dio = Dio(
      BaseOptions(baseUrl: "http://openapi.data.go.kr", queryParameters: {
        "ServiceKey":
            "SybIVL6/ZSkWIHbjbD1bmCvXuPFY5a7g52aSX8I07ofzCkU4VNmIeZGLNcB3UnReXfKifrt6OxXOE2l73SrUPg=="
      }),
    );
  }

  Future<List<Covid19StatisticsModel>> fetchCovidStatistics(
      {String? startDate, String? endDate}) async {
    var query = Map<String, String>();
    if (startDate != null) {
      query.putIfAbsent('startCreateDt', () => startDate);
    }
    if (endDate != null) {
      query.putIfAbsent('endCreateDt', () => endDate);
    }
    var response = await _dio.get(
        "/openapi/service/rest/Covid19/getCovid19InfStateJson",
        queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return results
          .map<Covid19StatisticsModel>(
              (element) => Covid19StatisticsModel.fromXml(element))
          .toList();
    } else {
      return Future.value(null);
    }
  }
}
