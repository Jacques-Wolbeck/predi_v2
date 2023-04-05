import 'package:predi_v2/shared/cda/br.com.multcare/bean/patient.dart';

class Author extends Patient {
  String? _crm;
  Author();

  void setCrm(String crm) => _crm = crm;
  String? getCrm() => _crm;
}
