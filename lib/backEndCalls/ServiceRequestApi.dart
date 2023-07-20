import 'dart:convert';
import 'dart:math';

// import 'package:assetmng/model/asset_model.dart';
import 'package:assetmng/model/service_model.dart';
import 'package:http/http.dart' as http;

class RandomNumberGenerator {
  int _previousNumber = 0;

  int generateNewNumber() {
    final random = Random();

    int minRange = _previousNumber != 0 ? _previousNumber + 1 : 1000000;
    int maxRange = 9999999;

    int randomNumber = minRange + random.nextInt(maxRange - minRange);

    _previousNumber = randomNumber;

    return randomNumber;
  }

  int get previousNumber => _previousNumber;
}

class ServiceRequestApi {
  static const apiUrl = 'http://192.168.1.11:8080/services';
  // static const apiUrl = 'http://localhost:8080/assets';

  static Future<List<ServiceR>> getServiceRequests(
      String role, String rolecode) async {
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);

      List<ServiceR> serviceRequest =
          jsonList.map((json) => ServiceR.fromJson(json)).toList();

      if (role == "admin" || role == "subAdmin") {
        return serviceRequest;
      } else if (role == "location") {
        List<ServiceR> serviceRequestLocation = [];
        for (var i = 0; i < serviceRequest.length; i++) {
          if (serviceRequest[i].location == rolecode) {
            serviceRequestLocation.add(serviceRequest[i]);
          }
        }
        if (serviceRequestLocation.isNotEmpty) {
          return serviceRequestLocation;
        }
        return [];
      } else {
        List<ServiceR> serviceRequestVendor = [];
        for (var i = 0; i < serviceRequest.length; i++) {
          if (serviceRequest[i].supplier == rolecode) {
            serviceRequestVendor.add(serviceRequest[i]);
          }
        }
        if (serviceRequestVendor.isNotEmpty) {
          return serviceRequestVendor;
        }
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<String> addserviceRequests(ServiceR service) async {
    RandomNumberGenerator rng = RandomNumberGenerator();
    int randomNumber = rng.generateNewNumber();
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(service.copyWith(id: randomNumber)),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyServiceCreated';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Create Service with status: ${response.statusCode}';
    }
  }

  static Future<String> deleteserviceRequests(int id) async {
    final url = "$apiUrl/$id";
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyDeleteAsset';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Delete Asset with status: ${response.statusCode}';
    }
  }

  static Future<String> updateserviceRequests(ServiceR service) async {
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(service),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyUpdateService';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Update service with status: ${response.statusCode}';
    }
  }
}
