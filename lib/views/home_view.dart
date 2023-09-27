import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_generator/controller/controller.dart';
import 'package:random_generator/views/number_view.dart';
import 'package:random_generator/views/word_view.dart';

class HomeView extends GetView<AppController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Generator"),
        bottom: TabBar(
          controller: controller.tabController.value,
          tabs: controller.myTabs,
        ),
      ),
      body: TabBarView(
        controller: controller.tabController.value,
        children: const [
          NumberView(),
          WordView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (controller.tabController.value.index) {
            case 0:
              controller.selectNumber(context);
              break;
            case 1:
              controller.addWord(context);
              break;
            default:
              controller.selectNumber(context);
          }
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
