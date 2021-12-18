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

  Future<Covid19StatisticsModel> fetchCovidStatistics() async{
    var response = await _dio.get("/openapi/service/rest/Covid19/getCovid19InfStateJson");

    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    if (results.isNotEmpty){
      return Covid19StatisticsModel.fromXml(results.first);
    }else{
      return Future.value(null);
    }
  }
}
