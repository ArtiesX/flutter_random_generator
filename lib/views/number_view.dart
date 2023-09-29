import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_generator/controller/number_controller.dart';

class NumberView extends GetView<NumberController> {
  const NumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          // color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
              child: Obx(
            () => Text(
              controller.ansRandom.value.toString(),
              style: TextStyle(
                  fontSize: controller.ansRandom.value ==
                          'Press the button to start randomly'
                      ? 18.0
                      : 72.0),
            ),
          )),
        ),
        Obx(
          () => Column(
            children: [
              Text("min : ${controller.minNumber.value}",
                  style: const TextStyle(fontSize: 18.0)),
              const SizedBox(height: 40),
              Text('max : ${controller.maxNumber.value}',
                  style: const TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 150),
          alignment: Alignment.center,
          child: const Text("You can Shake to Random!",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 12),
          child: TextButton(
              onPressed: () => controller.setNumber(context),
              child: const Text(
                "Set Range",
                style: TextStyle(fontSize: 18.0),
              )),
        ),
      ],
    );
  }
}
