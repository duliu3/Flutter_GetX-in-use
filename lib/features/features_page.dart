import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_in_use/channel_page.dart';
import 'package:flutter_getx_in_use/features/features_controller.dart';
import 'package:flutter_getx_in_use/list/simple_list.dart';
import 'package:flutter_getx_in_use/main_controller.dart';
import 'package:flutter_getx_in_use/state/state_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../page.dart';
import '../state/state.dart';
import '../websocket_control.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (FeaturesController controller) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Way 1
                    // Get.to(() => PageOne());
                    // Way 2
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageOne(),
                        settings: RouteSettings(name: '/middle'),
                      ),
                    );
                  },
                  child: Text('Navigation'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => StatePage());
                    // Get.toNamed("/state_page");
                  },
                  child: Text('State Management'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.to(() => WebSocketPage(url: 'wss://'));
                  },
                  child: Text('Websocket'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ListPage());
                  },
                  child: Text('Simple List'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ChannelPage());
                  },
                  child: Text('Native Channel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}