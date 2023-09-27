import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final rnd = Random();

class TextController extends GetxController {
  var textList = [].obs;
  var cloneList = [];
  late TextEditingController textCtrl;
  var ansRandom = "Press the button to start randomly".obs;
  Rx<bool> isAnimate = false.obs;
  Rx<bool> isRepeated = false.obs;
  @override
  void onInit() {
    super.onInit();
    textCtrl = TextEditingController();
  }

  @override
  void onClose() {
    textCtrl.dispose();
    super.onClose();
  }

  void setText(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 16),
                  const Center(
                      child: Text(
                    "Add Text",
                    style: TextStyle(fontSize: 18.0),
                  )),
                  const SizedBox(height: 16),
                  TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.go,
                    controller: textCtrl,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Text Input",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                    onSubmitted: (String value) {
                      addText();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () {
                        addText();
                      },
                      child: const Text("OK")),
                ],
              ),
            ),
          );
        }).then((value) => clearController());
  }

  void addText() {
    if (textCtrl.text.isNotEmpty) {
      textList.add(textCtrl.text);
    }
    Get.back();
  }

  void clearController() {
    textCtrl.clear();
  }

  void clearList() {
    textList.clear();
  }

  void randomText() {
    if (textList.isNotEmpty) {
      ansRandom.value = textList[rnd.nextInt(textList.length)].toString();
    } else {}
  }
}
