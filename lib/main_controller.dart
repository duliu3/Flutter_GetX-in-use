import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class MainController extends GetxController {
  var tabIndex = 0;
  void changeIndex(int index) {
    tabIndex = index;
    update();
  }
}