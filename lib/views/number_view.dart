import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_generator/controller/controller.dart';

class NumberView extends GetView<AppController> {
  const NumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Container(
                height: 300,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Center(
                    child: Text(
                  "${controller.randomNumber}",
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500),
                )),
              ),
              const SizedBox(height: 100),
              Text("${controller.minNumber} to ${controller.maxNumber}",
                  style: const TextStyle(fontSize: 28.0, color: Colors.grey)),
              const SizedBox(height: 100),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    controller.getRandomNumber();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Random",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
