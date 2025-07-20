import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serious_game/core/apis/api.dart';

class LandingController extends GetxController {
  LandingController();
  var userProfile = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;
  final _storage = GetStorage();

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      var res = await ApiService.getProfile(_storage.read('token'));
      userProfile.value = res.data;
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    await fetchUserProfile();
    super.onInit();
  }

  @override
  void onClose() {}
}
