/// @author Alex
/// @date 2023/7/31
/// @Description:
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_getx_in_use/list/simple_list_controller.dart';
import 'package:get/get.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ListController controller = Get.put(ListController());

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data.json');
      controller.nameList.value = RxList<dynamic>(json.decode(jsonString));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (ListController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('List'),
          ),
          body: Obx(
            () => ListView.builder(
              itemCount: controller.nameList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(controller.nameList[index]['name']?? "a"),
                  subtitle: Text(controller.nameList[index]['phone']?? "0"),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
