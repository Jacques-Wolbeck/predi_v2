import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:predi_v2/android/widgets/buttons/survey_buttons/survey_foward_button.dart';
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
}
