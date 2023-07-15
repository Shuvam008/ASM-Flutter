import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:assetmng/model/user_model.dart';

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

class AuthApi {
  static const apiUrl = 'http://192.168.1.11:8080/users';
  // static const apiUrl = 'http://localhost:8080/users';

  static Future<String> addUser(
    String name,
    String email,
    String password,
  ) async {
    RandomNumberGenerator rng = RandomNumberGenerator();
    int randomNumber = rng.generateNewNumber();

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body:
          '{"id":"$randomNumber","name":"$name","email":"$email","password":"$password"}',
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return 'successfullyAdded';
    } else {
      return 'Failed to add user with status: ${response.statusCode}';
    }
  }

  static Future<bool> isEmailExist(String email) async {
    bool emailExists = false;
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      // Example email address to check
      String targetEmail = email;
      // Check if the email exists within the user data
      for (var user in users) {
        if (user['email'] == targetEmail) {
          emailExists = true;
          break;
        }
      }
    }
    return emailExists;
  }

  static Future<String> logIn(String username, String password) async {
    String loginStatus = "";
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      // Example email address to check
      String targetUsername = username;
      String targetPassword = password;
      // Check if the email exists within the user data
      for (var user in users) {
        if (user['username'] == targetUsername) {
          if (user['password'] == targetPassword) {
            loginStatus = "ok";
            break;
          } else {
            loginStatus = "incorrectPassword";
            break;
          }
        } else {
          loginStatus = "notexist";
        }
      }
      return loginStatus;
    } else {
      return "${response.statusCode} Error";
    }
  }

  static Future<User?> getUser(String username) async {
    final url = "$apiUrl/username/$username";
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json' // Required for CORS support to work
      },
    );
    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      if (user['username'] != null) {
        print(user['username']);
        return User.fromJson(user);
      } else {
        print(user['username']);
        return null;
      }
    } else {
      return null;
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
}
