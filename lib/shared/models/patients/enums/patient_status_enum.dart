enum PatientStatusEnum {
  noData('Sem Dados',
      "É necessário cadastrar todas as taxas, para que possamos realizar o diagnóstico, isso pode ser feito no botão abaixo 'Atualize suas taxas'"),
  diabetes('Diabetes!',
      'Há alto risco de diabetes, recomenda-se ir a um médico especialista para acompanhamento.'),
  preDiabetes('Pré-Diabetes',
      'Há um alto risco que você se encontre no quadro de pré-diabetes, recomenda-se ir ao médico.'),
  highFastingGlucose('Situação de Risco!',
      'Sua glicemia em jejum está muito alta, recomenda-se, nesse caso, que procure um médico assim que possível.'),
  alteredFastingGlucose('Situação de Risco!',
      'Seus dados indicam um quadro de glicemia de jejum alterada, recomenda-se, nesse caso, ir ao médico assim que possível.'),
  highGlucose75g('Situação de Risco!',
      'Sua glicemia 2 horas após sobrecarga com 75g de glicose está muito alta, você deve procurar um médico.'),
  goodFastingGlucose('Regular',
      'Sua glicemia de jejum atual está boa, mas devem ser feitas novas avaliações a cada 3 anos ou conforme o risco.');

  final String status;
  final String content;

  const PatientStatusEnum(this.status, this.content);
}
