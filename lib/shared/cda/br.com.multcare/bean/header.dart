class Header {
  String? _realmCode;
  String? _typeId;
  String? _extension1;
  String? _template;
  String? _idRoot;
  String? _extension2;
  String? _code;
  String? _efetiveTime;
  String? _id;
  int _version = 0;

  Header();

  String? getRealmCode() => _realmCode;

  void setRealmCode(String realmCode) => _realmCode = realmCode;

  String? getTypeId() => _typeId;

  void setTypeId(String typeId) => _typeId = typeId;

  String? getExtension1() => _extension1;

  void setExtension1(String extension1) => _extension1 = extension1;

  String? getTemplate() => _template;

  void setTemplate(String template) => _template = template;

  String? getIdRoot() => _idRoot;

  void setIdRoot(String idRoot) => _idRoot = idRoot;

  String? getExtension2() => _extension2;

  void setExtension2(String extension2) => _extension2 = extension2;

  String? getCode() => _code;

  void setCode(String code) => _code = code;

  String? getEfetiveTime() => _efetiveTime;

  void setEfetiveTime(String efetiveIime) => _efetiveTime = efetiveIime;

  String? getId() => _id;

  void setId(String id) => _id = id;

  int getVersion() => _version;

  void setVersion(int version) => _version = version;
}
