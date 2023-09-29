import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';

final random = Random();

class NumberController extends GetxController {
  var minNumber = 0.obs;
  var maxNumber = 100.obs;
  late TextEditingController minCtrl;
  late TextEditingController maxCtrl;
  var ansRandom = "Press the button to start randomly".obs;
  Rx<bool> isAnimate = false.obs;
  late Timer timer;
  late ShakeDetector _detector;
  @override
  void onInit() {
    super.onInit();
    minCtrl = TextEditingController();
    maxCtrl = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();

    _detector = ShakeDetector.waitForStart(onPhoneShake: () {
      isAnimate.value = true;
      _detector.stopListening();
      getRandomNumber();
    });

    _detector.startListening();
  }

  @override
  void onClose() {
    minCtrl.dispose();
    maxCtrl.dispose();
    super.onClose();
  }

  void setNumber(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 8),
                  const Center(
                      child: Text("Min to Max Number",
                          style: TextStyle(fontSize: 18.0))),
                  const SizedBox(height: 16),
                  TextField(
                    autofocus: true,
                    controller: minCtrl,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Min Number",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    textInputAction: TextInputAction.go,
                    controller: maxCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Max Number",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                    onSubmitted: (String? value) {
                      getNumber();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () {
                        getNumber();
                      },
                      child: const Text("OK")),
                ],
              ),
            ),
          );
        }).then((value) => clearController());
  }

  void getNumber() {
    if (minCtrl.text.isNotEmpty && maxCtrl.text.isNotEmpty) {
      int min = int.parse(minCtrl.text);
      int max = int.parse(maxCtrl.text);
      if (max > min) {
        minNumber.value = min;
        maxNumber.value = max;
      }
    }
    Get.back();
  }

  void clearController() {
    minCtrl.clear();
    maxCtrl.clear();
  }

  Future<void> getRandomNumber() async {
    _detector.stopListening();
    isAnimate.value == true
        ? timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
            ansRandom.value = RandomNubmer.generate(
                    min: minNumber.value, max: maxNumber.value)
                .toString();
          })
        : null;
    await Future.delayed(const Duration(seconds: 2), () {
      timer.cancel();
    });
    isAnimate.value = false;
    _detector.startListening();
  }
}

extension RandomNubmer on int {
  static int generate({required int min, required int max}) {
    return min + random.nextInt((max + 1) - min);
  }
}
