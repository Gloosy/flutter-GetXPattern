import 'package:food_delivery_app/data/api/api_service.dart';
import 'package:food_delivery_app/models/SignUp_model.dart';
import 'package:food_delivery_app/utils/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_response.dart';
import '../utils/api_url.dart';

class AuthRepo {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiService, required this.sharedPreferences});

  Future<UserResponse> registration(SignUp signUp) async {
    try{
      dynamic response = await apiService.userRegister(ApiUrl.registerUrl, signUp);
      print('repo $response');
      return response = UserResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
  Future<UserResponse> login(String email,String password) async {
    try{
      dynamic response = await apiService.userLogin(ApiUrl.loginUrl,email,password);
      print('repo $response');
      return response = UserResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
   Future<void> saveUserToken(String token)async{
    apiService.token = token;
    await sharedPreferences.setString(SharedPref.TOKEN, token);
  }

   bool getUserToken(){
    return sharedPreferences.containsKey(SharedPref.TOKEN);
  }

}
