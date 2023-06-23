enum SurveyContentEnum {
  genHlth(
      title: 'Saúde Geral',
      description:
          'Em uma escala de 1-5, como você considera sua saúde em geral?',
      image: 'assets/images/report.png'),
  highBp(
      title: 'Pressão Arterial',
      description: 'Você possui pressão alta?',
      image: 'assets/images/report.png'),
  highChol(
      title: 'Colesterol',
      description: 'Você possui colesterol alto?',
      image: 'assets/images/report.png'),
  bmi(
      title: 'IMC',
      description: 'Índice de Massa Corpórea',
      image: 'assets/images/report.png'),
  income(
      title: 'Renda Mensal',
      description:
          'Em uma escala de 1-8, onde a sua renda familiar mensal se encontra?',
      image: 'assets/images/report.png'),
  diffWalk(
      title: 'Dificuldade para Andar',
      description:
          'Você tem sérias dificuldades para caminhar ou subir escadas?',
      image: 'assets/images/report.png'),
  physHlth(
      title: 'Saúde Física',
      description:
          'Por quantos dias nos últimos 30, você ficou com algum problema físico?',
      image: 'assets/images/report.png'),
  education(
      title: 'Educação',
      description: 'Qual o seu grau de escolaridade?',
      image: 'assets/images/report.png'),
  heartDiseaseorAttack(
      title: 'Doença Cardíaca',
      description:
          'Você tem doença arterial coronariana ou teve já teve infarto do miocárdio (ataque cardíaco)?',
      image: 'assets/images/report.png'),
  physActivity(
      title: 'Atividade Física',
      description: 'Você fez atividade física nos últimos 30 dias?',
      image: 'assets/images/report.png'),
  mentHlth(
      title: 'Saúde Mental',
      description:
          'Por quantos dias nos últimos 30, você teve problemas com a sua saúde mental?',
      image: 'assets/images/report.png'),
  cholCheck(
      title: 'Verificação de Colesterol',
      description: 'Você verificou seu colesterol nos últimos 5 anos?',
      image: 'assets/images/report.png');

  final String title;
  final String description;
  final String image;

  const SurveyContentEnum(
      {required this.title, required this.description, required this.image});
}
