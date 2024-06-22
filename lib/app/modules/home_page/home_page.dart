import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/home_page/home_controller.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_page.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Resume Builder',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: MediaQuery.of(context).size.shortestSide * 0.08,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildImage(context),
            buildMessage(context),
            buildButton(context),
          ],
        )),
      ),
    );
  }

  buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: RoundedButton(
        text: 'Create',
        onPressed: () => Get.to(() => const ResumeMakerPage()),
      ),
    );
  }

  buildMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'Your free resume maker.',
        style: TextStyle(color: Colors.black87, fontSize: MediaQuery.of(context).size.shortestSide * 0.05),
        textAlign: TextAlign.center,
      ),
    );
  }

  buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Image.asset(
        'assets/cv.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height * 0.2,
      ),
    );
  }
}
