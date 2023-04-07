enum DataTypeEnum {
  rate('Taxas', 'Taxa'),
  measure('Medidas', 'Medida'),
  appointment('Consultas', 'Consulta'),
  glycatedHemoglobin('Hb1A1C', 'Hemoglobina glicada'),
  fastingGlucose('Jejum', 'Glicose em jejum'),
  glucose75g('Após 75g', 'Glicose após 75g'),
  weight('Peso', '-'),
  bmi('IMC', 'Índice de Massa Corpórea'),
  circumference('Circunferência', 'Circunferência abdominal');

  final String value1;
  final String value2;

  const DataTypeEnum(this.value1, this.value2);
}
