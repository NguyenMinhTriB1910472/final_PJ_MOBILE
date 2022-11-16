import 'package:get/get.dart';
import 'package:grab_app_clone_2/data/api/api_client.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppContrants.POPULAR_PRODUCT_URI);
  }
}