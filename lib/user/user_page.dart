import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_in_use/state/state_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../page.dart';
import '../state/state.dart';
import '../websocket_control.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (StateController controller) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed("/");
                  },
                  child: Text('ALEX Fortune: ${controller.deposit}'),
                ),
                QrImageView(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}