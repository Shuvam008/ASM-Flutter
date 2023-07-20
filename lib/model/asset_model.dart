// To parse this JSON data, do
//
//     final asset = assetFromJson(jsonString);

import 'dart:convert';

Asset assetFromJson(String str) => Asset.fromJson(json.decode(str));

String assetToJson(Asset data) => json.encode(data.toJson());

class Asset {
  int id;
  String equipmenttype;
  String make;
  String serialnumber;
  int subassetnumber;
  String suppliedto;
  String ponumber;
  String purchasedate;
  String supplier;
  String supplytostationdate;
  String warrantyexpired;
  String codallife;
  String codallifeexpired;
  String warranty;
  String amc;
  String purchasefrom;
  String fund;
  String suppliermail;
  String supplierphonenumber;
  bool isActive;

  Asset({
    required this.id,
    required this.equipmenttype,
    required this.make,
    required this.serialnumber,
    required this.subassetnumber,
    required this.suppliedto,
    required this.ponumber,
    required this.purchasedate,
    required this.supplier,
    required this.supplytostationdate,
    required this.warrantyexpired,
    required this.codallife,
    required this.codallifeexpired,
    required this.warranty,
    required this.amc,
    required this.purchasefrom,
    required this.fund,
    required this.suppliermail,
    required this.supplierphonenumber,
    required this.isActive,
  });

  Asset copyWith({
    int? id,
    String? equipmenttype,
    String? make,
    String? serialnumber,
    int? subassetnumber,
    String? suppliedto,
    String? ponumber,
    String? purchasedate,
    String? supplier,
    String? supplytostationdate,
    String? warrantyexpired,
    String? codallife,
    String? codallifeexpired,
    String? warranty,
    String? amc,
    String? purchasefrom,
    String? fund,
    String? suppliermail,
    String? supplierphonenumber,
    bool? isActive,
  }) =>
      Asset(
        id: id ?? this.id,
        equipmenttype: equipmenttype ?? this.equipmenttype,
        make: make ?? this.make,
        serialnumber: serialnumber ?? this.serialnumber,
        subassetnumber: subassetnumber ?? this.subassetnumber,
        suppliedto: suppliedto ?? this.suppliedto,
        ponumber: ponumber ?? this.ponumber,
        purchasedate: purchasedate ?? this.purchasedate,
        supplier: supplier ?? this.supplier,
        supplytostationdate: supplytostationdate ?? this.supplytostationdate,
        warrantyexpired: warrantyexpired ?? this.warrantyexpired,
        codallife: codallife ?? this.codallife,
        codallifeexpired: codallifeexpired ?? this.codallifeexpired,
        warranty: warranty ?? this.warranty,
        amc: amc ?? this.amc,
        purchasefrom: purchasefrom ?? this.purchasefrom,
        fund: fund ?? this.fund,
        suppliermail: suppliermail ?? this.suppliermail,
        supplierphonenumber: supplierphonenumber ?? this.supplierphonenumber,
        isActive: isActive ?? this.isActive,
      );

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json["id"],
        equipmenttype: json["equipmenttype"],
        make: json["make"],
        serialnumber: json["serialnumber"],
        subassetnumber: json["subassetnumber"],
        suppliedto: json["suppliedto"],
        ponumber: json["ponumber"],
        purchasedate: json["purchasedate"],
        supplier: json["supplier"],
        supplytostationdate: json["supplytostationdate"],
        warrantyexpired: json["warrantyexpired"],
        codallife: json["codallife"],
        codallifeexpired: json["codallifeexpired"],
        warranty: json["warranty"],
        amc: json["amc"],
        purchasefrom: json["purchasefrom"],
        fund: json["fund"],
        suppliermail: json["suppliermail"],
        supplierphonenumber: json["supplierphonenumber"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "equipmenttype": equipmenttype,
        "make": make,
        "serialnumber": serialnumber,
        "subassetnumber": subassetnumber,
        "suppliedto": suppliedto,
        "ponumber": ponumber,
        "purchasedate": purchasedate,
        "supplier": supplier,
        "supplytostationdate": supplytostationdate,
        "warrantyexpired": warrantyexpired,
        "codallife": codallife,
        "codallifeexpired": codallifeexpired,
        "warranty": warranty,
        "amc": amc,
        "purchasefrom": purchasefrom,
        "fund": fund,
        "suppliermail": suppliermail,
        "supplierphonenumber": supplierphonenumber,
        "isActive": isActive,
      };
}
