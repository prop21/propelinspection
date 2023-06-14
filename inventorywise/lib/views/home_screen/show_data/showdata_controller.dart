import 'package:get/get.dart';

import '../../../service/home/home_service.dart';

class ShowDataController extends GetxController{
  var value=0.obs;
  var service = HomeService();
  @override
  void onInit() {
    super.onInit();


  }
  @override
  void onReady(){
    // Get called after widget is rendered on the screen
    super.onReady();


  }
  void deleteData(id) async {
    await service.deleteProperty(id,);
  }
}