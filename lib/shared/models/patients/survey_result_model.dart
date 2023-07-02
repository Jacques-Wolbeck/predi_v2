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
