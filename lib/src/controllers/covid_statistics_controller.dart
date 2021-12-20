import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:public_api_app/src/canvas/arrow_clip_path.dart';
import 'package:public_api_app/src/models/covid_statistics.dart';
import 'package:public_api_app/src/models/covid_vaccine_statistics.dart';
import 'package:public_api_app/src/repository/covid_statistics_repository.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDatas = <Covid19StatisticsModel>[].obs;
  RxList<CovidVaccineStatisticsModel> _vaccineDatas =
      <CovidVaccineStatisticsModel>[].obs;
  double maxDecideValue = 0;

  @override
  void onInit() {
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
    super.onInit();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(const Duration(days: 7)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    var result = await _covidStatisticsRepository.fetchCovidStatistics(
        startDate: startDate, endDate: endDate);
    var vaccineResult =
        await _covidStatisticsRepository.fetchCovidVaccineStatistics();

    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);
          if (maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
    if (vaccineResult.isNotEmpty) {
      _vaccineDatas.addAll(vaccineResult);
    }
  }

  Covid19StatisticsModel get todayData => _todayData.value;

  List<Covid19StatisticsModel> get weekDays => _weekDatas;

  List<CovidVaccineStatisticsModel> get vaccineData => _vaccineDatas;

  ArrowDirection calculateUpDown(double value) {
    if (value == 0) {
      return ArrowDirection.MIDDLE;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}
