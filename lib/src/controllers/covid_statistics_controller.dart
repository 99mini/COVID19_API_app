import 'package:get/get.dart';
import 'package:public_api_app/src/models/covid_statistics.dart';
import 'package:public_api_app/src/repository/covid_statistics_repository.dart';

class CovidStatisticsController extends GetxController{
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> covidStatistic = Covid19StatisticsModel().obs;

  @override
  void onInit() {
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
    super.onInit();
  }

  void fetchCovidState() async{
    var result = await _covidStatisticsRepository.fetchCovidStatistics();
    if (result != null){
      covidStatistic(result);
    }
  }
}