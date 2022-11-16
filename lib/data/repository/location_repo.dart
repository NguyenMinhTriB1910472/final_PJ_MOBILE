import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:grab_app_clone_2/models/AdressModel.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../data/api/api_client.dart';
class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getAddressfromGeoCode(LatLng latlng) async{
    print('${AppContrants.GEOCODE_URI}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}');
    return await apiClient.getData('${AppContrants.GEOCODE_URI}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}'
    );
  }
  String getUserAddress(){
    return sharedPreferences.getString(AppContrants.USER_ADDRESS)??"";
  }
  Future<Response> addAddress(AddressModel addressModel) async{
    return await apiClient.postData(AppContrants.USER_ADD_ADDRESS, addressModel.toJson());
  }
  Future<Response> getAllAddress() async{
    return await apiClient.getData(AppContrants.ADDRESS_LIST_URI);
  }
  Future<bool> saveUserAddress(String address) async{
    apiClient.updateHeader(sharedPreferences.getString(AppContrants.TOKEN)!);
    return await sharedPreferences.setString(AppContrants.USER_ADDRESS, address);
  }
}