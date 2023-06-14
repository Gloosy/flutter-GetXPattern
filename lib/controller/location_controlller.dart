import 'dart:convert';

import 'package:food_delivery_app/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {

  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loading = false;
  bool get loading => _loading;

  bool _changeAddress = true;
  bool get changeAddress => _changeAddress;

  late Position _position;
  late Position _pickPosition;

  Position get position => _position;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;


  bool _updateAdressData = true;
  late GoogleMapController _mapController;
  GoogleMapController get mapController  => _mapController;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool addressPage) async {
    if (_updateAdressData) {
      _loading = true;
      update();
      try {
        if (addressPage) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
              addressPage ? _placemark = Placemark(name: address): _pickPlacemark = Placemark(name: address);
        }
      } catch (e) {
        print('error :$e');
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String address = 'Location not found';
    var response = await locationRepo.getAddressFromGeocode(latLng);
    if (response['status'] == 'OK') {
      address = response['results'][0]['formatted_address'];
      print('address asd${address} status:${response['status']}');
    } else {
      print('Error getting google api');
    }
    return address;
  }

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  getUserAddress(){
    late AddressModel addressModel;
      _getAddress  = jsonDecode(locationRepo.getUserAddress()); //jsonDecode convert String to Mao<String ,dynamic>
    try{
      addressModel = AddressModel.fromJson( jsonDecode(locationRepo.getUserAddress()));
    }catch(e){
      print(e.toString());
    }
    return addressModel;
  }

  List<String> _addressTypeList = ['home', 'office', 'other'];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  void setAddressTypeIndex(int index){
     _addressTypeIndex = index;
     update();
  }

  Future<bool> saveAddress(AddressModel addressModel)async{
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

}
