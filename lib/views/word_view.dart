import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_generator/controller/controller.dart';

class WordView extends GetView<AppController> {
  const WordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: 300,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${controller.randomWord}",
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          controller.getRandomWord();
                        },
                        child: const Text("Random",
                            style:
                                TextStyle(fontSize: 24, color: Colors.white))),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "List",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () => controller.clearList(),
                      icon: const Icon(Icons.delete_forever_rounded))
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.wordList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    print("Tile Index : " + controller.wordList[index]);
                    print(controller.wordList);
                  },
                  title: Text(controller.wordList[index].toString()),
                  trailing: IconButton(
                    onPressed: () {
                      controller.wordList.removeAt(index);
                    },
                    icon: const Icon(Icons.delete_rounded),
                  ),
                );
              },
            ),
          ],
        )));
  }
}
