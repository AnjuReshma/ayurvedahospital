import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Logincontroller extends ChangeNotifier {
  String? token;
  bool isLoading = false;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();

    var uri = Uri.parse('https://flutter-amr.noviindus.in/api/Login'); // Replace with your actual API URL

    var request = http.MultipartRequest('POST', uri);
    request.fields['username'] = username;
    request.fields['password'] = password;

    try {
      var response = await request.send();
      final body = await response.stream.bytesToString();
      final data = jsonDecode(body);

      if (response.statusCode == 200 && data['token'] != null) {
        token = data['token'];
        isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      log("Error: $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}
