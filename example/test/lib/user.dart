import 'package:yao_core_builder/yao_core_builder.dart';

part 'user.g.dart';

@OdooModel(className: "User", tableName: "res.users", columns: [
  DbColumn(name: "id", type: int),
  DbColumn(name: "login", type: String),
  DbColumn(name: "namke", type: String),
  DbColumn(name: "withouttype")
])
void _;
