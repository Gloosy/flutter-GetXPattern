import 'package:food_delivery_app/data/api/api_service.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/api_url.dart';

class ProductRepository{
  final ApiService _apiService =ApiService();

  Future<ProductModel> getAllProduct () async{
    try{
      var response = await _apiService.getAll(ApiUrl.allProductUrl);
      print('repo :$response');
      return response = ProductModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

}