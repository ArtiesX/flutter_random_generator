import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/text_controller.dart';

class TextView extends GetView<TextController> {
  const TextView({super.key});

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
                        : controller.ansRandom.value == 'No Item'
                            ? 18.0
                            : 40.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Switch(
                        value: controller.isRepeated.value,
                        onChanged: (bool value) {
                          controller.isRepeated.value = value;
                        }),
                  ),
                  const SizedBox(width: 4),
                  controller.isRepeated.isFalse
                      ? const Text("Repeated")
                      : const Text("No Repeated")
                ],
              ),
              TextButton(
                  onPressed: () => controller.setText(context),
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 16.0),
                  )),
            ],
          ),
        ),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.textList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.textList[index].toString()),
                trailing: IconButton(
                  onPressed: () => controller.textList.removeAt(index),
                  icon: const Icon(Icons.delete_rounded),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
