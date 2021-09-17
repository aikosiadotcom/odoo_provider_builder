// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// OdooProviderModelGenerator
// **************************************************************************

class User implements IOdooModel {
  final int? id; //false
  final String? login; //false
  final String? namke; //false
  final dynamic? withouttype; //false

  User({this.id, this.login, this.namke, this.withouttype});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  int? getId() {
    return this.id;
  }

  @override
  String getTableName() => "res.users";

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
      if (entry.value == null || entry.key == 'id') {
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

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int,
      login: json['login'] as String,
      namke: json['namke'] as String,
      withouttype: json['withouttype'] as dynamic);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'namke': instance.namke,
      'withouttype': instance.withouttype
    };
