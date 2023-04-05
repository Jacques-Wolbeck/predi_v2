class HealthHistoric {
  String? _section;
  String? _moodCode;
  String? _templateId;
  String? _code;
  String? _codeSystem;
  String? _codeName;
  String? _display;
  String? _title;
  String? _text;

  HealthHistoric();

  String? getSection() => _section;

  void setSection(String section) => _section = section;

  String? getMoodCode() => _moodCode;

  void setMoodCode(String moodCode) => _moodCode = moodCode;

  String? getTemplateId() => _templateId;

  void setTemplateId(String templateId) => _templateId = templateId;

  String? getCode() => _code;

  void setCode(String code) => _code = code;

  String? getCodeSystem() => _codeSystem;

  void setCodeSystem(String codeSystem) => _codeSystem = codeSystem;

  String? getCodeName() => _codeName;

  void setCodeName(String codeName) => _codeName = codeName;

  String? getDisplay() => _display;

  void setDisplay(String display) => _display = display;

  String? getTitle() => _title;

  void setTitle(String title) => _title = title;

  String? getText() => _text;

  void setText(String text) => _text = text;
}
