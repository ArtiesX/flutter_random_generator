import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_generator/controller/controller.dart';
import 'package:random_generator/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => AppController());
      }),
    );
  }
}
