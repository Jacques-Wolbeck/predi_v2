enum SurveyContentEnum {
  genHlth(
      key: 'gen_hlth',
      title: 'Saúde Geral',
      description:
          'Em uma escala de 1-5, como você considera sua saúde em geral?',
      image: 'assets/images/report.png',
      list: ['1- Excelente', '2- Muito Bom', '3- Bom', '4 - Pobre', '5- Ruim']),
  highBp(
      key: 'high_bp',
      title: 'Pressão Arterial',
      description: 'Você possui pressão alta?',
      image: 'assets/images/report.png',
      list: []),
  highChol(
      key: 'high_chol',
      title: 'Colesterol',
      description: 'Você possui colesterol alto?',
      image: 'assets/images/report.png',
      list: []),
  bmi(
      key: 'bmi',
      title: 'IMC',
      description: 'Índice de Massa Corpórea',
      image: 'assets/images/report.png',
      list: []),
  income(
      key: 'income',
      title: 'Renda Mensal',
      description:
          'Em uma escala de 1-8, onde a sua renda familiar mensal se encontra?',
      image: 'assets/images/report.png',
      list: []),
  diffWalk(
      key: 'diffwalk',
      title: 'Dificuldade para Andar',
      description:
          'Você tem sérias dificuldades para caminhar ou subir escadas?',
      image: 'assets/images/report.png',
      list: []),
  physHlth(
      key: 'phys_hlth',
      title: 'Saúde Física',
      description:
          'Por quantos dias nos últimos 30, você ficou com algum problema físico?',
      image: 'assets/images/report.png',
      list: [
        'Entre: 1 - 6 dias ',
        'Entre: 7 - 11 dias',
        'Entre: 12 - 16 dias',
        'Entre: 17 - 20 dias',
        'Entre: 21 - 25 dias',
        'Entre: 26 - 30 dias'
      ]),
  education(
      key: 'education',
      title: 'Educação',
      description: 'Qual o seu grau de escolaridade?',
      image: 'assets/images/report.png',
      list: [
        '1- Nunca Frequentou a Escola ',
        '2- Ensino Fundamental',
        '3- Ensino Médio Incompleto',
        '4- Ensino Medio Completo',
        '5- Ensino Superior ou Curso Técnico Incompleto',
        '6- Ensino Superior ou Curso Técnico Completo'
      ]),
  heartDiseaseorAttack(
      key: 'heart_disease_or_attack',
      title: 'Doença Cardíaca',
      description:
          'Você tem doença arterial coronariana ou já teve infarto do miocárdio (ataque cardíaco)?',
      image: 'assets/images/report.png',
      list: []),
  physActivity(
      key: 'phys_activity',
      title: 'Atividade Física',
      description: 'Você fez atividade física nos últimos 30 dias?',
      image: 'assets/images/report.png',
      list: []),
  mentHlth(
      key: 'ment_hlth',
      title: 'Saúde Mental',
      description:
          'Por quantos dias nos últimos 30, você teve problemas com a sua saúde mental?',
      image: 'assets/images/report.png',
      list: []),
  cholCheck(
      key: 'chol_check',
      title: 'Verificação de Colesterol',
      description: 'Você verificou seu colesterol nos últimos 5 anos?',
      image: 'assets/images/report.png',
      list: []);

  final String key;
  final String title;
  final String description;
  final String image;
  final List<String> list;

  const SurveyContentEnum(
      {required this.key,
      required this.title,
      required this.description,
      required this.image,
      required this.list});
}
