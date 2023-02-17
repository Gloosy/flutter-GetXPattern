import 'package:food_delivery_app/data/api/api_response.dart';
import 'package:food_delivery_app/models/SignUp_model.dart';
import 'package:food_delivery_app/models/user_response.dart';
import 'package:food_delivery_app/repository/Auth_repo.dart';
import 'package:food_delivery_app/utils/shared_preferences_key.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  ApiResponse<UserResponse> userResponse = ApiResponse.loading();

   onSetUserResponse(ApiResponse<UserResponse> response){
     userResponse = response;
     //print('set user value : $response');
     update();
   }

  onSetAuthResponse(ApiResponse<UserResponse> response){
    userResponse = response;
    print('set user value : ${response.data?.accessToken}');
    if(response.data!.success!){
      authRepo.saveUserToken(response.data!.accessToken!);
      print('save Token');
      //authRepo.sharedPreferences.remove(SharedPref.TOKEN);
      //print('c${authRepo.sharedPreferences.containsKey(SharedPref.TOKEN)}');
    }
    update();
  }

  Future registration(SignUp signUp) async{
      _isLoading = true;
      await authRepo.registration(signUp).then((value) {
        onSetUserResponse(ApiResponse.complete(value));
      }).onError((error, stackTrace) {
        onSetUserResponse(ApiResponse.error(error.toString()));
      });
      _isLoading = false;
      update();
  }

  Future login(String email,String password) async{
    _isLoading = true;
    await authRepo.login(email,password).then((value) {
      onSetAuthResponse(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      onSetAuthResponse(ApiResponse.error(error.toString()));
    });
    _isLoading = false;
    update();
  }
   bool autoLogin(){
     print('${authRepo.getUserToken()}');
    return authRepo.getUserToken();
  }

  void logout(){
     authRepo.sharedPreferences.remove(SharedPref.CART_HISTORY_LIST);
     authRepo.sharedPreferences.remove(SharedPref.CART_LIST);
     authRepo.sharedPreferences.remove(SharedPref.TOKEN);
  }
}