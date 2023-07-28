import 'package:flutter_getx_in_use/features/features_controller.dart';
import 'package:flutter_getx_in_use/main_controller.dart';
import 'package:flutter_getx_in_use/state/state_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<FeaturesController>(() => FeaturesController());
    Get.lazyPut<StateController>(() => StateController());
  }
}