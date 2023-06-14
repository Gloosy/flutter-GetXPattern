import 'dart:convert';
import 'dart:io';
import 'package:food_delivery_app/models/SignUp_model.dart';
import 'package:food_delivery_app/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_exception.dart';
class ApiService {

  late String token;

  ApiService() {
    token = ApiUrl.token;
  }

  dynamic responseJson;

  Future<dynamic> getAll(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      print("api service:$response");
      responseJson = returnJsonResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  Future<dynamic> userRegister(String uri, SignUp signUp) async {
    SignUp data = signUp;
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6ImRYNkhMcWVPNFVPWkE5aHdTallOblE9PSIsInZhbHVlIjoiYis5YWtnWEJka2NSczIvQ2RmK25ySkVOQmZVK2RPb0ZmSWRpck9iRVk5Nkx5Y3gzV2tGSURPNnhsNEc2a1Z2bHJTNHRrSk9OVHFPNnhBQ0VTcUN2L0I0dFVPZlVHVHg2YjI4dmZNei91bVhoMFhDTkdZbitTQjBiZW9wMVdWOXciLCJtYWMiOiJkZWVlZGQ1M2M0NWI4ODRjMzU1ODFiYjhjMzYzMTU0Mzg5ODI0MTMyMzFkODUxYTQ5YTdjZjA5OWFhMmU1ZDhmIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IlBsWXIvc2duR3U0eTJpOElOYXlOMmc9PSIsInZhbHVlIjoiRDYrVGdPNG5QTHUwaXNYLzh4eFUxKzA0RUJTWkljQUI2THRsWkp6QzJOT0hIR3pwS2pDNmtFNmZXNlZGWWtSeVYwbklTVm1aZlhUSnIxdzFBTTlGQ3IzVUtUV0ZiWnpKblZZRUdFWmdkWnhZZGZYK3BadnpvN2NQVGN5bVVtRFMiLCJtYWMiOiJlYzQyYTQ0MDVlYTkyZTI1MWNlY2I2NGEzNmIxYWI4MDhhYmQ5NmNlZGQ3Mjg5YjJjMDFkMDFlMWZmNjg3ZjM2IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'POST', Uri.parse(uri));
    request.body  = json.encode({
      "name"      : data.name,
      "email"     : data.email,
      "password"  : data.password,
      "phone"     : data.phone
    });
    request.headers.addAll(headers);

    var response = await request.send();
    var resource = await response.stream.bytesToString();
    print("$resource");
    return json.decode(resource);
  }


  Future<dynamic> userLogin(String uri,String email,String password) async{
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6ImRYNkhMcWVPNFVPWkE5aHdTallOblE9PSIsInZhbHVlIjoiYis5YWtnWEJka2NSczIvQ2RmK25ySkVOQmZVK2RPb0ZmSWRpck9iRVk5Nkx5Y3gzV2tGSURPNnhsNEc2a1Z2bHJTNHRrSk9OVHFPNnhBQ0VTcUN2L0I0dFVPZlVHVHg2YjI4dmZNei91bVhoMFhDTkdZbitTQjBiZW9wMVdWOXciLCJtYWMiOiJkZWVlZGQ1M2M0NWI4ODRjMzU1ODFiYjhjMzYzMTU0Mzg5ODI0MTMyMzFkODUxYTQ5YTdjZjA5OWFhMmU1ZDhmIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IlBsWXIvc2duR3U0eTJpOElOYXlOMmc9PSIsInZhbHVlIjoiRDYrVGdPNG5QTHUwaXNYLzh4eFUxKzA0RUJTWkljQUI2THRsWkp6QzJOT0hIR3pwS2pDNmtFNmZXNlZGWWtSeVYwbklTVm1aZlhUSnIxdzFBTTlGQ3IzVUtUV0ZiWnpKblZZRUdFWmdkWnhZZGZYK3BadnpvN2NQVGN5bVVtRFMiLCJtYWMiOiJlYzQyYTQ0MDVlYTkyZTI1MWNlY2I2NGEzNmIxYWI4MDhhYmQ5NmNlZGQ3Mjg5YjJjMDFkMDFlMWZmNjg3ZjM2IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request('POST', Uri.parse(uri));
    request.body = json.encode({
      "email"    : email,
      "password" : password
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var resource = await response.stream.bytesToString();
    print("$resource");
    return json.decode(resource);
  }

  
}

dynamic returnJsonResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);

    case 400:
      throw BadRequestException(response.body.toString());

    case 401:
      throw UnAuthorizedException(response.body.toString());

    default:
      throw FetchDataException('unexpected error occurred');
  }
}