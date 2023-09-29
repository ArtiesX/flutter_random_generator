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
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
              child: Obx(
            () => Text(
              controller.ansRandom.value.toString(),
              style: TextStyle(
                  fontSize: controller.ansRandom.value ==
                          'Press the button to start randomly'
                      ? 18.0
                      : 40.0),
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                    "From ${controller.minNumber.value} - ${controller.maxNumber.value}",
                    style: const TextStyle(
                      fontSize: 16.0,
                    )),
              ),
              TextButton(
                  onPressed: () => controller.setNumber(context),
                  child: const Text("Set Range")),
            ],
          ),
        ),
      ],
    );
  }
}
