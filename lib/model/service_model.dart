// To parse this JSON data, do
//
//     final serviceR = serviceRFromJson(jsonString);

import 'dart:convert';

ServiceR serviceRFromJson(String str) => ServiceR.fromJson(json.decode(str));

String serviceRToJson(ServiceR data) => json.encode(data.toJson());

class ServiceR {
  int id;
  String equipmenttype;
  String serialnumber;
  String location;
  String supplier;
  dynamic descriptionlocation;
  dynamic descriptionvendor;
  String requestdate;
  String requesttime;
  String requestacknowledgedate;
  String requestacknowledgetime;
  String requestclosedate;
  String requestclosetime;
  dynamic locationapprovedate;
  dynamic locationapprovetime;

  ServiceR({
    required this.id,
    required this.equipmenttype,
    required this.serialnumber,
    required this.location,
    required this.supplier,
    this.descriptionlocation,
    this.descriptionvendor,
    required this.requestdate,
    required this.requesttime,
    required this.requestacknowledgedate,
    required this.requestacknowledgetime,
    required this.requestclosedate,
    required this.requestclosetime,
    this.locationapprovedate,
    this.locationapprovetime,
  });

  ServiceR copyWith({
    int? id,
    String? equipmenttype,
    String? serialnumber,
    String? location,
    String? supplier,
    dynamic descriptionlocation,
    dynamic descriptionvendor,
    String? requestdate,
    String? requesttime,
    String? requestacknowledgedate,
    String? requestacknowledgetime,
    String? requestclosedate,
    String? requestclosetime,
    dynamic locationapprovedate,
    dynamic locationapprovetime,
  }) =>
      ServiceR(
        id: id ?? this.id,
        equipmenttype: equipmenttype ?? this.equipmenttype,
        serialnumber: serialnumber ?? this.serialnumber,
        location: location ?? this.location,
        supplier: supplier ?? this.supplier,
        descriptionlocation: descriptionlocation ?? this.descriptionlocation,
        descriptionvendor: descriptionvendor ?? this.descriptionvendor,
        requestdate: requestdate ?? this.requestdate,
        requesttime: requesttime ?? this.requesttime,
        requestacknowledgedate:
            requestacknowledgedate ?? this.requestacknowledgedate,
        requestacknowledgetime:
            requestacknowledgetime ?? this.requestacknowledgetime,
        requestclosedate: requestclosedate ?? this.requestclosedate,
        requestclosetime: requestclosetime ?? this.requestclosetime,
        locationapprovedate: locationapprovedate ?? this.locationapprovedate,
        locationapprovetime: locationapprovetime ?? this.locationapprovetime,
      );

  factory ServiceR.fromJson(Map<String, dynamic> json) => ServiceR(
        id: json["id"],
        equipmenttype: json["equipmenttype"],
        serialnumber: json["serialnumber"],
        location: json["location"],
        supplier: json["supplier"],
        descriptionlocation: json["descriptionlocation"],
        descriptionvendor: json["descriptionvendor"],
        requestdate: json["requestdate"],
        requesttime: json["requesttime"],
        requestacknowledgedate: json["requestacknowledgedate"],
        requestacknowledgetime: json["requestacknowledgetime"],
        requestclosedate: json["requestclosedate"],
        requestclosetime: json["requestclosetime"],
        locationapprovedate: json["locationapprovedate"],
        locationapprovetime: json["locationapprovetime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "equipmenttype": equipmenttype,
        "serialnumber": serialnumber,
        "location": location,
        "supplier": supplier,
        "descriptionlocation": descriptionlocation,
        "descriptionvendor": descriptionvendor,
        "requestdate": requestdate,
        "requesttime": requesttime,
        "requestacknowledgedate": requestacknowledgedate,
        "requestacknowledgetime": requestacknowledgetime,
        "requestclosedate": requestclosedate,
        "requestclosetime": requestclosetime,
        "locationapprovedate": locationapprovedate,
        "locationapprovetime": locationapprovetime,
      };
}
