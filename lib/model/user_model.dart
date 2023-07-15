// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String username;
  String password;
  String locationname;
  String locationcode;
  String role;
  String rolegroup;
  int maxdevices;
  int currentdevices;
  String email;
  String phonenumber;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.locationname,
    required this.locationcode,
    required this.role,
    required this.rolegroup,
    required this.maxdevices,
    required this.currentdevices,
    required this.email,
    required this.phonenumber,
  });

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? locationname,
    String? locationcode,
    String? role,
    String? rolegroup,
    int? maxdevices,
    int? currentdevices,
    String? email,
    String? phonenumber,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        locationname: locationname ?? this.locationname,
        locationcode: locationcode ?? this.locationcode,
        role: role ?? this.role,
        rolegroup: rolegroup ?? this.rolegroup,
        maxdevices: maxdevices ?? this.maxdevices,
        currentdevices: currentdevices ?? this.currentdevices,
        email: email ?? this.email,
        phonenumber: phonenumber ?? this.phonenumber,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        locationname: json["locationname"],
        locationcode: json["locationcode"],
        role: json["role"],
        rolegroup: json["rolegroup"],
        maxdevices: json["maxdevices"],
        currentdevices: json["currentdevices"],
        email: json["email"],
        phonenumber: json["phonenumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "locationname": locationname,
        "locationcode": locationcode,
        "role": role,
        "rolegroup": rolegroup,
        "maxdevices": maxdevices,
        "currentdevices": currentdevices,
        "email": email,
        "phonenumber": phonenumber,
      };
}
