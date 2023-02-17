import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const GOOGLE_API_KEY = 'AIzaSyC_D4atN7fHHIrUkU313377zZwtxQtERdc';

class GoogleMapService {
  // static String generateLocationPreviewImage({
  //   double? latitude,
  //   double? longitude,
  // }) {
  //   return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  // }
  Future<dynamic> getPlaceAddress(LatLng latLng) async{
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    //print('from Service:${response.body}');
    return json.decode(response.body);
  }
}
