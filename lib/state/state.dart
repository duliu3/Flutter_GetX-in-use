import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_in_use/state/state_controller.dart';
import 'package:flutter_getx_in_use/user/user_page.dart';
import 'package:get/get.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class StatePage extends StatelessWidget {
  StateController controller = Get.put(StateController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                "Money: ${controller.deposit.toString()}",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => Text(
                      "${controller.beg.toString()}",
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.red,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      controller.increment();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.red,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      controller.payoff();
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Go Back'),
            ),

            ElevatedButton(
              onPressed: () {
                Get.to(
                  () => UserPage(),);
              },
              child: const Text('My Account'),
            ),
          ],
        ),
      ),
    );
  }
}
