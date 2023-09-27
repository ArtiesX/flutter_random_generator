import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "dart:math";

final random = Random();

class AppController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Tab> myTabs = const <Tab>[
    Tab(text: 'Number'),
    Tab(text: 'Word'),
  ];

  late Rx<TabController> tabController;
  var wordList = [].obs;
  var minNumber = 0.obs;
  var maxNumber = 100.obs;
  var minCtrl = TextEditingController();
  var maxCtrl = TextEditingController();
  var textCtrl = TextEditingController();
  var randomWord = 'Please Click Random button'.obs;
  var randomNumber = 'Please Click Random button'.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length).obs;
  }

  @override
  void onClose() {
    tabController.value.dispose();
    super.onClose();
  }

  void selectNumber(BuildContext context) {
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
                  const Center(child: Text("Min to Max Number")),
                  const SizedBox(height: 8),
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
                      setNumber();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () {
                        setNumber();
                      },
                      child: const Text("OK")),
                ],
              ),
            ),
          );
        }).then((value) => clearNumberController());
  }

  void setNumber() {
    if (minCtrl.text.isNotEmpty && maxCtrl.text.isNotEmpty) {
      int a = int.parse(minCtrl.text);
      int b = int.parse(maxCtrl.text);
      if (b > a) {
        minNumber.value = a;
        maxNumber.value = b;
      }
    }

    Get.back();
  }

  void clearNumberController() {
    minCtrl.clear();
    maxCtrl.clear();
  }

  void clearTextControlelr() {
    textCtrl.clear();
  }

  void addWord(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 12),
                  const Center(child: Text("Add Text")),
                  const SizedBox(height: 12),
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
                    onSubmitted: (String? value) {
                      setWord();
                    },
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () {
                        setWord();
                      },
                      child: const Text("OK")),
                ],
              ),
            ),
          );
        }).then((value) => clearTextControlelr());
  }

  void setWord() {
    if (textCtrl.text.isNotEmpty) {
      wordList.add(textCtrl.text);
    }
    clearTextControlelr();
    Get.back();
  }

  void clearList() {
    wordList.clear();
  }

  void getRandomWord() {
    if (wordList.isNotEmpty) {
      randomWord.value = wordList[random.nextInt(wordList.length)].toString();
    }
  }

  void getRandomNumber() {
    randomNumber.value =
        RandomNumber.generate(min: minNumber.value, max: maxNumber.value)
            .toString();
  }

  Future<void> onRefresh() async {}
}

extension RandomNumber on int {
  static int generate({required int min, required int max}) {
    return min + random.nextInt((max + 1) - min);
  }
}
