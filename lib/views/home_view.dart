import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_generator/controller/number_controller.dart';
import 'package:random_generator/controller/text_controller.dart';
import 'package:random_generator/views/number_view.dart';
import 'package:random_generator/views/text_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int screenIndex = 0;
  late bool showNavigationDrawer;
  static const List<Widget> screenList = [
    NumberView(),
    TextView(),
  ];
  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });

    switch (screenIndex) {
      case 0:
        Get.lazyPut(() => NumberController());
        // Get.delete<TextController>();
        break;
      case 1:
        Get.lazyPut(() => TextController());
        // Get.delete<NumberController>();
        break;
    }
    closeDrawer();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => NumberController());
    Get.lazyPut(() => TextController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width > 450;
  }

  @override
  Widget build(BuildContext context) {
    final nCtrl = Get.find<NumberController>();
    final tCtrl = Get.find<TextController>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: screenIndex == 0
            ? const Text("Random Number")
            : const Text("Random Text"),
        actions: screenIndex == 1
            ? [
                IconButton(
                    tooltip: "Delete All",
                    onPressed: () {
                      final deleteCtrl = Get.find<TextController>();
                      deleteCtrl.textList.clear();
                    },
                    icon: const Icon(Icons.delete_rounded)),
              ]
            : [],
      ),
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 32, 16, 10),
            child: Text(
              'Random Generator App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
              icon: Icon(Icons.numbers_rounded), label: Text("Number")),
          const NavigationDrawerDestination(
              icon: Icon(Icons.text_format_rounded), label: Text("Text")),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
        ],
      ),
      body: screenList[screenIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Container(
          height: Get.height * 0.07,
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              shadowColor: Colors.black,
              elevation: 4,
            ),
            onPressed:
                nCtrl.isAnimate.value == false && tCtrl.isAnimate.value == false
                    ? () async {
                        switch (screenIndex) {
                          case 0:
                            nCtrl.isAnimate.value = true;
                            nCtrl.getRandomNumber();
                            break;
                          case 1:
                            tCtrl.isAnimate.value = true;
                            tCtrl.randomText();
                            break;
                        }
                      }
                    : null,
            child: const Center(
              child: Text(
                'Random',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
