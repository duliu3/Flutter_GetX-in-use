import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class StateController extends GetxController {
  var beg = 0.obs;
  var salary = 1000.obs;
  int get deposit=> beg.value + salary.value;

  increment() {
    beg.value++;
  }

  payoff() {
    salary.value+=1000;
  }
}