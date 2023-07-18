class SurveyResultModel {
  final String name;
  final String version;

  SurveyResultModel({required this.name, required this.version});

  factory SurveyResultModel.fromJson(Map<String, dynamic> result) {
    return SurveyResultModel(name: result['name'], version: result['version']);
  }

  @override
  String toString() {
    return 'Name: $name  -> Version: $version';
  }
}

class PredictionResult {
  final String label;
  final int prediction;

  PredictionResult({required this.label, required this.prediction});
  factory PredictionResult.fromJson(Map<String, dynamic> predict) {
    return PredictionResult(
        label: predict['label'], prediction: predict['prediction']);
  }

  @override
  String toString() {
    return '$label -> $prediction';
  }
}
