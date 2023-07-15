import 'dart:convert';
import 'dart:math';
import 'package:assetmng/model/user_model.dart';
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

class UserApi {
  static const apiUrl = 'http://192.168.1.11:8080/users';
  // static const apiUrl = 'http://localhost:8080/assets';

  static Future<List<User>?> getSubAdminUsers() async {
    var response = await http.get(Uri.parse(apiUrl));
    List<User> final_users = [];
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
      for (var i = 0; i < users.length; i++) {
        if (users[i].role == "subAdmin") {
          final_users.add(users[i]);
        }
      }
      return final_users;
    } else {
      return null;
    }
  }

  static Future<List<User>?> getLocationUsers() async {
    var response = await http.get(Uri.parse(apiUrl));
    List<User> final_users = [];
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
      for (var i = 0; i < users.length; i++) {
        if (users[i].role == "location") {
          final_users.add(users[i]);
        }
      }
      return final_users;
    } else {
      return null;
    }
  }

  static Future<List<User>?> getVendorUsers() async {
    var response = await http.get(Uri.parse(apiUrl));
    List<User> final_users = [];
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<User> users = jsonList.map((json) => User.fromJson(json)).toList();
      for (var i = 0; i < users.length; i++) {
        if (users[i].role == "vendor") {
          final_users.add(users[i]);
        }
      }
      return final_users;
    } else {
      return null;
    }
  }

  static Future<String> addUser(User user) async {
    RandomNumberGenerator rng = RandomNumberGenerator();
    int randomNumber = rng.generateNewNumber();
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.copyWith(id: randomNumber)),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return 'UserExist';
      }
      print("successfully : ${response.statusCode}");
      return 'successfullyCreated';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Added user with status: ${response.statusCode}';
    }
  }

  static Future<String> updateUser(User user) async {
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyUpdated';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Update user with status: ${response.statusCode}';
    }
  }

  static Future<String> deleteUser(int id) async {
    final url = "$apiUrl/$id";
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("successfully : ${response.statusCode}");
      return 'successfullyDeleteUser';
    } else {
      print("Failed : ${response.statusCode}");
      return 'Failed to Delete User with status: ${response.statusCode}';
    }
  }
}
