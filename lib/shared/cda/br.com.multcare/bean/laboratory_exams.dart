import 'package:predi_v2/shared/cda/br.com.multcare/bean/allergy.dart';

class LaboratoryExams extends Allergy {
  String? _id;
  String? _code;

  LaboratoryExams();

  void setId(String id) => _id = id;

  String? getId() => _id;

  void setCode(String code) => _code = code;

  String? getCode() => _code;
}
