library test;

import 'package:odoo_provider/odoo_provider.dart';

part 'user.g.dart';

@OdooModel(className: "User", tableName: "res.users", columns: [
  DbColumn(name: "id", type: int),
  DbColumn(name: "login", type: String),
  DbColumn(name: "name", type: String)
])
void _;
