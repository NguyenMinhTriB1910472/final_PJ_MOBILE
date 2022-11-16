import 'package:get/get.dart';
import 'package:grab_app_clone_2/data/api/api_client.dart';
import 'package:grab_app_clone_2/ultis/api_constrants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppContrants.RECOMMENDED_POPULAR_PRODUCT_URI);
  }
}
