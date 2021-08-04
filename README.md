# Odoo Provider Builder

Since it's too much writing to implement IOdooModel using [odoo_provider](https://pub.dev/packages/odoo_provider), i develop this package. So, writing model will become easily.

Please add this package as **dev dependency** to your project

# Usage

1. Create your model with structure like following [example: user.dart]

```
import 'package:odoo_provider/odoo_provider.dart';

part 'user.g.dart'; //this is required

@OdooModel(className: "User", tableName: "res.users", columns: [
  DbColumn(name: "id", type: int),
  DbColumn(name: "login", type: String),
  DbColumn(name: "name", type: String)
])
void _;
```

2. and then run following command:

```
flutter pub run build_runner build
```

if above command run successfully, you'll see file user.g.dart

if you want to know more about above command, you can checkout at [source_gen](https://pub.dev/packages/source_gen)

# Example

You can checkout folder in example\test
