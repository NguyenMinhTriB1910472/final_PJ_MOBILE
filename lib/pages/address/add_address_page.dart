import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_app_clone_2/controllers/auth_controller.dart';
import 'package:grab_app_clone_2/controllers/location_controller.dart';
import 'package:grab_app_clone_2/controllers/user_controller.dart';
import 'package:grab_app_clone_2/models/AdressModel.dart';
import 'package:grab_app_clone_2/pages/address/pick_address_map.dart';
import 'package:grab_app_clone_2/routes/route_helper.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/ultis/dimensions.dart';
import 'package:grab_app_clone_2/widgets/app_text_field.dart';
import 'package:grab_app_clone_2/widgets/big_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../widgets/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: const LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(10.030166119804772, 105.77066894140177);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().
        saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address page"),
          backgroundColor: AppColor.mainColor,
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            if (userController.userModel != null &&
                _contactPersonName.text.isEmpty) {
              _contactPersonName.text = '${userController.userModel?.name}';
              _contactPersonNumber.text = '${userController.userModel?.phone}';
              if (Get.find<LocationController>().addressList.isNotEmpty) {
                _addressController.text =
                    Get.find<LocationController>().getUserAddress().address;
              }
            }
            return GetBuilder<LocationController>(
                builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ""}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              print("address is my view is " + _addressController.text);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 2, color: Theme.of(context).primaryColor)),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latLng){
                              print("mở rộng!");
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                arguments: PickAddress(
                                  fromSignup: false,
                                  fromAddress: true,
                                  googleMapController:  locationController.mapController
                                )
                              );
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationButtonEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Dimension.height20),
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locationController.setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimension.width20,
                                        vertical: Dimension.width20),
                                    margin: EdgeInsets.only(left: Dimension.width20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimension.radius15/3),
                                      color: Theme.of(context).cardColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        )
                                      ]
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(index==0?Icons.home:index==1?Icons.work:Icons.location_on,
                                        color: locationController.addressTypeList==index?
                                        AppColor.mainColor:Theme.of(context).disabledColor),
                                      ],
                                    ),
                                  ),

                                );
                              }),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimension.height10),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width10),
                      child: BigText(
                        text: "Delivery Address",
                        size: Dimension.font20,
                      ),
                    ),
                    SizedBox(height: Dimension.height10),
                    AppTextField(
                        textEditingController: _addressController,
                        hintText: "Your Address",
                        iconData: Icons.map),
                    SizedBox(height: Dimension.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width10),
                      child: BigText(
                        text: "Contact name",
                        size: Dimension.font20,
                      ),
                    ),
                    SizedBox(height: Dimension.height20),
                    AppTextField(
                        textEditingController: _contactPersonName,
                        hintText: "Your Name",
                        iconData: Icons.person),
                    SizedBox(height: Dimension.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width10),
                      child: BigText(
                        text: "Your number",
                        size: Dimension.font20,
                      ),
                    ),
                    SizedBox(height: Dimension.height20),
                    AppTextField(
                        textEditingController: _contactPersonNumber,
                        hintText: "Your Number",
                        iconData: Icons.phone),
                  ],
                ),
              );
            });
          },
        ),
      bottomNavigationBar:
        GetBuilder<LocationController>(builder: (locationController) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Dimension.height20*7,
            padding: EdgeInsets.only(
                top: Dimension.height30,
                bottom: Dimension.height30,
                left: Dimension.height30,
                right: Dimension.height30),
            decoration: BoxDecoration(
                color: AppColor.buttonBackgroundColors,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20 * 2),
                    topRight: Radius.circular(Dimension.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                    onTap: () {
                      AddressModel _addressType= AddressModel(addressType:locationController.addressTypeList[
                      locationController.addressTypeIndex],
                      address: _addressController.text,
                      contactPersonName: _contactPersonName.text,
                      contactPersonNumber: _contactPersonNumber.text,
                      latitude: locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString(),
                      );
                      print(_addressType.toJson());
                      locationController.addAddress(_addressType).then((response){
                        if(response.isSuccess){
                          Get.back();
                          Get.snackbar("Address", "Added Successfully");
                        }else{
                          Get.snackbar("Address", "Couldn't save address");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: Dimension.height20,
                          right: Dimension.height20,
                          top: Dimension.height20,
                          bottom: Dimension.height20),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimension.radius20),
                        color: AppColor.mainColor,
                      ),
                      child: BigText(
                        text: "Save Address",
                        color: Colors.white,
                        size: Dimension.font20,
                      ),
                    ))
              ],
            ),
          )
        ],
      );
    }),
    );
  }
}
