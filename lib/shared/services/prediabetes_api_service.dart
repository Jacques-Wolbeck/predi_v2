import 'package:predi_v2/shared/models/patients/survey_model.dart';
import 'package:predi_v2/shared/models/patients/survey_result_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrediabetesApiService {
  static final PrediabetesApiService instance = PrediabetesApiService._init();
  PrediabetesApiService._init();

  Future<SurveyResultModel?> getModelInfo() async {
    var url = Uri.parse(
        'http://192.168.1.146:8000'); //esse é o ip da rede do computador (localhost)

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return SurveyResultModel.fromJson(jsonResponse);
    } else {
      throw Exception('Falha ao carregar');
    }
  }

  Future<PredictionResult?> predict(SurveyModel survey) async {
    var url = Uri.parse('http://192.168.1.146:8000/predict');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(survey.toJSON()));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return PredictionResult.fromJson(jsonResponse);
    } else {
      throw Exception('Falha ao carregar');
    }
  }
}
