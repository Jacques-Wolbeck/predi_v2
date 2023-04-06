enum DataTypeEnum {
  rate('Taxas'),
  measure('Medidas'),
  appointment('Consultas'),
  glycatedHemoglobin('Hb1A1C'),
  fastingGlucose('Jejum'),
  glucose75g('Após 75g'),
  weight('Peso'),
  bmi('IMC'),
  circumference('Circunferência');

  final String value;

  const DataTypeEnum(this.value);
}
