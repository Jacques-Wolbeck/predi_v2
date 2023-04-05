class Patient {
  int _id = 0;
  String? _addr;
  String? _phone;
  String? _name;
  String? _family;
  String? _admin;
  String? _codeSystem;
  String? _birth;
  String? _maritalStatus;
  String? _religious;
  String? _race;
  String? _ethnicGroup;
  String? _birthPlace;
  String? _addrBirthPlace;
  String? _idExtension;

  Patient();

  int getId() => _id;

  void setId(int id) => _id = id;

  String? getAddr() => _addr;

  void setAddr(String addr) => _addr = addr;

  String? getPhone() => _phone;

  void setPhone(String phone) => _phone = phone;

  String? getName() => _name;

  void setName(String name) => _name = name;

  String? getFamily() => _family;

  void setFamily(String family) => _family = family;

  String? getAdmin() => _admin;

  void setAdmin(String admin) => _admin = admin;

  String? getCodeSystem() => _codeSystem;

  void setCodeSystem(String codeSystem) => _codeSystem = codeSystem;

  String? getBirth() => _birth;

  void setBirth(String birth) => _birth = birth;

  String? getMaritalStatus() => _maritalStatus;

  void setMaritalStatus(String maritalStatus) => _maritalStatus = maritalStatus;

  String? getReligious() => _religious;

  void setReligious(String religious) => _religious = religious;

  String? getRace() => _race;

  void setRace(String race) => _race = race;

  String? getEthnicGroup() => _ethnicGroup;

  void setEthnicGroup(String ethnicGroup) => _ethnicGroup = ethnicGroup;

  String? getBirthPlace() => _birthPlace;

  void setBirthPlace(String birthPlace) => _birthPlace = birthPlace;

  String? getAddrBirthPlace() => _addrBirthPlace;

  void setAddrBirthPlace(String addrBirthPlace) =>
      _addrBirthPlace = addrBirthPlace;

  String? getIdExtension() => _idExtension;

  void setIdExtension(String idExtension) => _idExtension = idExtension;
}
