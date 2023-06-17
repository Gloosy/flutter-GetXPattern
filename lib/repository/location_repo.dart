
import 'package:food_delivery_app/utils/shared_preferences_key.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/google_map_service.dart';

class LocationRepo {
  
  final GoogleMapService locationService;
  final SharedPreferences sharedPreferences;
  
  LocationRepo({required this.locationService, required this.sharedPreferences});

  Future getAddressFromGeocode(LatLng latLng) async {
    return await locationService.getPlaceAddress(latLng);
  }

  String getUserAddress(){
    print('get');
    return sharedPreferences.getString(SharedPref.userAddress)?? '';
  }
  
  Future<bool> saveUserAddress(String address)async {
    print('save');
    return await sharedPreferences.setString(SharedPref.userAddress, address);
  }
}
