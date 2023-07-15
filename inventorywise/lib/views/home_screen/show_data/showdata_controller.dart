import 'package:get/get.dart';

import '../../../service/home/home_service.dart';

class ShowDataController extends GetxController {
  var value = 0.obs;
  var service = HomeService();
  var isLoading = false.obs;
  List<String> myList = [
    'Front & Side Aspects',
    'Entrance Hall',
    'Living Room 1',
    'Living Room 2',
    'Kitchen',
    'Rear Garden',
    'Landing',
    'Bedroom 1',
    'Bedroom 2',
    'Bedroom 3',
    'Bedroom 4',
    'Bedroom 5',
    'Bathroom 1',
    'Bathroom 2'
  ];
  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  @override
  void onReady() {
    // Get called after widget is rendered on the screen
    super.onReady();
  }

  void deleteData(id) async {
    await service.deleteProperty(id);
  }
}
