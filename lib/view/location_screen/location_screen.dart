
import 'package:food_delivery_app/controller/Auth_controller.dart';
import 'package:food_delivery_app/controller/location_controlller.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/view/location_screen/pick_location.dart';
import 'package:food_delivery_app/view/widgets/Text_field_widget.dart';
import 'package:food_delivery_app/view/widgets/title_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/colors.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController addressController = TextEditingController();
  final TextEditingController contactPersonNameController =
      TextEditingController();
  final TextEditingController contactPersonNumberController =
      TextEditingController();
  late bool _islogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(11.562108, 104.888535), zoom: 17);
  late LatLng _initialPosition = const LatLng(11.562108, 104.888535);

  @override
  void initState() {

    _islogged = Get.find<AuthController>().autoLogin();
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.mainColor,
      ),
      body: SafeArea(
        child: GetBuilder<LocationController>(
            builder: (controller){
          if(controller.addressList.isNotEmpty){
            addressController.text = controller.getUserAddress().address;
          }
          addressController.text =
          '${controller.placeMark.name ??''}${controller.placeMark.locality ??''}${controller.placeMark.postalCode ?? ''}${controller.placeMark.country?? ''}';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height30 * 5,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: Dimensions.height5),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.radius15 / 3),
                      border: Border.all(width: 2, color: Colors.black12)),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: () {
                          controller.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position) => _cameraPosition = position),
                        onMapCreated: (GoogleMapController googleMapController) {
                          controller.setMapController(googleMapController);
                        },
                        onTap: (latLng){
                          Get.toNamed(RouteHelper.getPickAddressScreen(),
                            arguments: PickLocationScreen(
                              fromAddress: true,
                              googleMapController: controller.mapController,
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Center(
                  child: SizedBox(
                    height: Dimensions.height50*1.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.addressTypeList.length,
                        itemBuilder: (context,index){
                          return InkWell(
                              onTap: (){
                                controller.setAddressTypeIndex(index);
                              },
                              child: Container(

                                padding: EdgeInsets.all(Dimensions.height20),
                                margin: EdgeInsets.symmetric(horizontal:Dimensions.width10,vertical: Dimensions.height5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20/3),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [BoxShadow(color: Colors.grey[200]!,spreadRadius: 1,blurRadius: 5)]
                                ),
                                child: Icon(
                                  index == 0 ?Icons.home : index == 1 ? Icons.work : Icons.location_on_outlined,
                                  color: controller.addressTypeIndex  == index? AppColors.mainColor :Theme.of(context).disabledColor ,
                                )
                              ));
                        }),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Padding(padding: EdgeInsets.only(left: Dimensions.width20),child: TitleText(text: 'Delivery Address')),
                SizedBox(height: Dimensions.height20),
                TextFieldWidget(textController: addressController, icon: Icons.map, hintText: 'Your address'),
                SizedBox(height: Dimensions.height20),
                Center(
                  child: Container(
                    height: Dimensions.bottomHeightBar,
                    padding: EdgeInsets.only(
                        top: Dimensions.height30,
                        bottom: Dimensions.height30,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20 * 2),
                            topRight: Radius.circular(Dimensions.radius20 * 2))),
                    child:  GestureDetector(
                      onTap: () {
                        AddressModel addressModel =AddressModel(addressType: controller.addressTypeList[controller.addressTypeIndex],
                          address: addressController.text,
                          contactPeronNumber: 'ronaldo',
                          contactPersonName: '01222222',
                          latitude: controller.position.latitude.toString(),
                          longitude: controller.position.longitude.toString(),
                        );
                        print('camera position lat:${controller.position.latitude}');
                        print('camera position lng:${controller.position.longitude}');
                        controller.saveAddress(addressModel);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width45,
                            vertical: Dimensions.height20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: TitleText(
                          text: ' Save Address',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
