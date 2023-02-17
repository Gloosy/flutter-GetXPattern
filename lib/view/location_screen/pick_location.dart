import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class PickLocationScreen extends StatefulWidget {
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickLocationScreen({Key? key,required this.fromAddress,this.googleMapController}) : super(key: key);
  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
