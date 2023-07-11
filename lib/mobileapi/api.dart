import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utill/app_constants.dart';

class CallApi {
  final String _url = AppConstants.baseUri;
//login or user authentication rest api
  Future<http.Response> postData(data, apiUrl) async {
    try {
      // + await _getToken()
      var fullUrl = Uri.parse(_url + apiUrl+await _getToken()); // Corrected line
      return await http.post(fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      return null; // or throw an exception or return an error response
    }
  }
//retrieve data from laravel rest api
  Future<http.Response> getDriverAssignedMails(apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders(),
      );
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      return null; // or throw an exception or return an error response
    }
  }
  //check if user already logged in
  Future<http.Response> checkLoginStatus(apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders(),
      );
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      return null; // or throw an exception or return an error response
    }
  }
  //logout function
  Future<http.Response> driverLogout(apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders(),
      );
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      return null; // or throw an exception or return an error response
    }
  }



  /*

  =================customer mobile rest api======================
   */

  Future<http.Response> customerRegister(data, apiUrl) async {
    try {
      var fullUrl = Uri.parse(_url + apiUrl); // Corrected line
      return await http.post(fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      return null; // or throw an exception or return an error response
    }
  }
  Future<http.Response> customerLogin(data, apiUrl) async {
    try {
      var fullUrl = Uri.parse(_url + apiUrl); // Corrected line
      return await http.post(fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      return null; // or throw an exception or return an error response
    }
  }










  //set header
  Map<String, String> _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }
//get token
  Future<String> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
