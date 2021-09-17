import 'package:build/build.dart';
import 'package:yao_core_builder/yao_core_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

List<DbColumn> _getDefinitions(List<dynamic> columns) {
  return columns.map((element) {
    String? fieldName = element.getField("name")!.toStringValue();
    final _type = element.getField("type")!.toTypeValue();
    Type? type;
    if (_type!.isDartCoreString == true) {
      type = String;
    } else if (_type.isDartCoreInt == true) {
      type = int;
    } else if (_type.isDartCoreBool == true) {
      type = bool;
    } else if (_type.isDartCoreDouble == true) {
      type = double;
    } else {
      type = dynamic;
    }

    bool? required = element.getField("required")!.toBoolValue();

    return DbColumn(
        name: fieldName == null ? "" : fieldName,
        type: type == null ? int : type,
        required: required == null ? false : required);
  }).toList();
}

String _getClassTopLevelFields(List<DbColumn> columns) {
  StringBuffer bf = StringBuffer();
  for (final column in columns) {
    bf.writeln(
        "final ${column.type.toString()}? ${column.name};//${column.required}");
  }

  return bf.toString();
}

String _getClassConstructor(String className, List<DbColumn> columns) {
  List<String> bf = [];
  for (final column in columns) {
    bf.add("this.${column.name}");
  }
  return "$className({${bf.join(",")}});";
}

String _getFromJson(String className, List<DbColumn> columns) {
  List<String> bf = [];
  for (final column in columns) {
    bf.add("${column.name}: json['${column.name}'] as ${column.type}");
  }

  return '''$className _\$${className}FromJson(Map<String, dynamic> json) {
    return $className(
      ${bf.join(",")}
    );
  }''';
}

String _getToJson(String className, List<DbColumn> columns) {
  List<String> bf = [];

  for (final column in columns) {
    bf.add("'${column.name}': instance.${column.name}");
  }

  return '''Map<String, dynamic> _\$${className}ToJson($className instance) => <String, dynamic>{
    ${bf.join(",")}
  };''';
}

class OdooProviderModelGenerator extends GeneratorForAnnotation<OdooModel> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // print("hello world");
    final className = annotation.read('className').stringValue;
    final tableName = annotation.read('tableName').stringValue;
    final columns = annotation.read('columns').listValue;
    final idFieldName = annotation.read("id").stringValue;
    List<DbColumn> columns2 = _getDefinitions(columns);
    return '''
class $className implements IOdooModel {
  ${_getClassTopLevelFields(columns2)}

  ${_getClassConstructor(className, columns2)}
  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);
  Map<String, dynamic> toJson() => _\$${className}ToJson(this);

  @override
  $className fromJson(Map<String, dynamic> json) {
    return $className.fromJson(json);
  }

  @override
  int? getId() {
    return this.$idFieldName;
  }

  @override
  String getTableName() => "$tableName";

  @override
  Map<String, dynamic> toJsonWithReduce(
      bool Function(MapEntry<String, dynamic> p1) validate) {
    Map<String, dynamic> fields = this.toJson();
    Map<String, dynamic> tmp = {};
    for (final field in fields.entries) {
      if (validate(field) == false) {
        continue;
      }

      tmp.putIfAbsent(field.key, () => field.value);
    }
    return tmp;
  }

  @override
  Map<String, dynamic> toJsonWithoutNullAndId() {
    return toJsonWithReduce((MapEntry entry) {
      if (entry.value == null || entry.key == '$idFieldName') {
        return false;
      }
      return true;
    });
  }

  @override
  List<String> getColumns() {
    List<String> resp = [];
    final tmp = this.toJson();
    for (final entry in tmp.keys) {
      resp.add(entry);
    }
    return resp;
  }
}

${_getFromJson(className, columns2)}

${_getToJson(className, columns2)}
    ''';
  }
}
