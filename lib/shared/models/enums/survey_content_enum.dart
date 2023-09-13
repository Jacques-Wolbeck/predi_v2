enum SurveyContentEnum {
  genHlth(
      key: 'gen_hlth',
      title: 'Saúde Geral',
      description:
          'Em uma escala de 1-5, como você considera sua saúde em geral?',
      image: 'assets/images/icons/gen_hlth_icon.png',
      list: ['1- Excelente', '2- Muito Bom', '3- Bom', '4 - Pobre', '5- Ruim']),
  highBp(
      key: 'high_bp',
      title: 'Pressão Arterial',
      description: 'Você possui pressão alta?',
      image: 'assets/images/icons/high_bp_icon.png',
      list: []),
  highChol(
      key: 'high_chol',
      title: 'Colesterol',
      description: 'Você possui colesterol alto?',
      image: 'assets/images/icons/high_chol_icon.png',
      list: []),
  bmi(
      key: 'bmi',
      title: 'IMC',
      description: 'Índice de Massa Corpórea',
      image: 'assets/images/icons/bmi_icon.png',
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
      image: 'assets/images/icons/diff_walk_icon.png',
      list: []),
  physHlth(
      key: 'phys_hlth',
      title: 'Saúde Física',
      description:
          'Por quantos dias nos últimos 30, você ficou com algum problema físico?',
      image: 'assets/images/icons/phys_hlth_icon.png',
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
      image: 'assets/images/icons/education_icon.png',
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
      image: 'assets/images/icons/heart_attack_icon.png',
      list: []),
  physActivity(
      key: 'phys_activity',
      title: 'Atividade Física',
      description: 'Qual a sua frequência de atividade física semanal?',
      image: 'assets/images/icons/phys_activity_icon.png',
      list: [
        'Sedentário',
        'Levemente Ativo (1-2 dias por semana)',
        'Moderadamente ativo (3-4 dias por semana)',
        'Altamente ativo (5-6 dias por semana)',
        'Extremamente ativo (Diariamente e até 2 vezes por dia)'
      ]),
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
      list: []),
  smoker(
      key: 'smoker',
      title: 'Consumo de Cigarro',
      description: 'Você já fumou pelos menos 100 cigarros durante sua vida?',
      image: 'assets/images/icons/smoker_icon.png',
      list: []),
  fruits(
      key: 'fruits',
      title: 'Frutas',
      description: 'Você consome frutas uma ou mais vezes por dia?',
      image: 'assets/images/icons/fruits_icon.png',
      list: []),
  veggies(
      key: 'veggies',
      title: 'Vegetais',
      description: 'Você consome vegetais uma ou mais vezes por dia?',
      image: 'assets/images/icons/veggies_icon.png',
      list: []),
  ;

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
