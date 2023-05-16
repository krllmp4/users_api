import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:users/model/usermodel.dart';
import 'package:users/constants/apiconsts.dart';

class ApiService {
  Future<List<Users>?> getUsers() async { //returns list.
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint); // 1- hit the get http request
      var response = await http.get(url); // check if api call was successful

      if (response.statusCode == 200) { // means nice , so we convert the json(response.body) to List using userFromJson
        List<Users> user = usersFromJson(response.body);
        return user;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
