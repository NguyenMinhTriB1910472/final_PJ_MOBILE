import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_app_clone_2/controllers/location_controller.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import 'package:grab_app_clone_2/ultis/dimensions.dart';
class PickAddress extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddress({Key? key, required this.fromSignup, required this.fromAddress
  ,this.googleMapController
  }) : super(key: key);

  @override
  State<PickAddress> createState() => _PickAddressState();
}

class _PickAddressState extends State<PickAddress> {
  late LatLng _intalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _intalPosition =LatLng(10.030864881555123, 105.77188460841124);
      _cameraPosition=CameraPosition(target: _intalPosition,zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _intalPosition =LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition =CameraPosition(target: _intalPosition,zoom: 17);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _intalPosition,zoom: 17

                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.loading?Image.asset("assets/image/loading1.png",height: 50,width: 50)
                        :CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimension.height45,
                    left: Dimension.width20,
                  right: Dimension.width20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimension.width10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(Dimension.radius20/2)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,size: 25,color: AppColor.yellowColor,),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlacemark.name??''}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
