import 'dart:convert';

import 'package:assetmng/model/asset_model.dart';
import 'package:http/http.dart' as http;

class AssetApi {
  static const apiUrl = 'http://192.168.1.11:8080/assets';
  // static const apiUrl = 'http://localhost:8080/assets';

  static Future<List<Asset>?> getAssets(String role, String rolecode) async {
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);

      List<Asset> assets =
          jsonList.map((json) => Asset.fromJson(json)).toList();

      if (role == "admin" || role == "subAdmin") {
        return assets;
      } else if (role == "location") {
        List<Asset> assetsLocation = [];
        for (var i = 0; i < assets.length; i++) {
          if (assets[i].suppliedto.toLowerCase() == rolecode.toLowerCase()) {
            assetsLocation.add(assets[i]);
          }
        }
        if (assetsLocation.isNotEmpty) {
          return assetsLocation;
        }
        return null;
      } else {
        List<Asset> assetsVendor = [];
        for (var i = 0; i < assets.length; i++) {
          if (assets[i].supplier.toLowerCase() == rolecode.toLowerCase()) {
            assetsVendor.add(assets[i]);
          }
        }
        if (assetsVendor.isNotEmpty) {
          return assetsVendor;
        }
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String> AddAssets(Asset asset) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(asset),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyCreated';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Create user with status: ${response.statusCode}';
    }
  }

  static Future<String> DeleteAssets(int id) async {
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

  static Future<String> UpdateAssets(Asset asset) async {
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(asset),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyUpdateAsset';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Update Asset with status: ${response.statusCode}';
    }
  }
}
