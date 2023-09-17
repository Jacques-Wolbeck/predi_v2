enum DataTypeEnum {
  rate(primaryTitle: 'Taxas', secondaryTitle: 'Taxa'),
  measure(primaryTitle: 'Medidas', secondaryTitle: 'Medida'),
  consultation(primaryTitle: 'Consultas', secondaryTitle: 'Consulta'),
  survey(primaryTitle: 'Survey', secondaryTitle: 'Informações Extras'),
  glycatedHemoglobin(
      primaryTitle: 'Hb1A1C',
      secondaryTitle: 'Hemoglobina glicada',
      measurementUnit: '%',
      minValue: 0.0,
      maxValue: 10.0),
  fastingGlucose(
      primaryTitle: 'Jejum',
      secondaryTitle: 'Glicose em jejum',
      measurementUnit: 'mg/dL',
      minValue: 40.0,
      maxValue: 180.0),
  glucose75g(
      primaryTitle: 'Após 75g',
      secondaryTitle: 'Glicose após 75g',
      measurementUnit: 'mg/dL',
      minValue: 60.0,
      maxValue: 200.0),
  weight(
      primaryTitle: 'Peso',
      secondaryTitle: 'Peso',
      measurementUnit: 'kg',
      minValue: 0.0,
      maxValue: 190.0),
  bmi(
      primaryTitle: 'IMC',
      secondaryTitle: 'Índice de Massa Corpórea',
      measurementUnit: 'kg/m',
      icon: 'assets/images/icons/bmi_icon.png'),
  circumference(
      primaryTitle: 'Circunferência',
      secondaryTitle: 'Circunferência abdominal',
      measurementUnit: 'cm',
      minValue: 00.0,
      maxValue: 180.0);

  final String primaryTitle;
  final String secondaryTitle;
  final String? measurementUnit;
  final double? minValue;
  final double? maxValue;
  final String? icon;

  const DataTypeEnum(
      {required this.primaryTitle,
      required this.secondaryTitle,
      this.measurementUnit,
      this.minValue,
      this.maxValue,
      this.icon});
}
