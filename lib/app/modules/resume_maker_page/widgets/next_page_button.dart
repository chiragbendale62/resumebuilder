import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';

class NextPageButton extends StatelessWidget {
  const NextPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResumeMakerController>();

    var pageOffset = 0.0;

    return Positioned(
      bottom: 24,
      right: 24,
      child: Transform.translate(
        offset: Offset(_getXOffset(pageOffset, MediaQuery.of(context).size.width), 0),
        child: ClipOval(
          child: Container(
            height: 32,
            width: 32,
            color: controller.nextButtonEnable.value ? Theme.of(context).primaryColor : Colors.grey,
            child: IconButton(
              padding: const EdgeInsets.all(4),
              color: Colors.white,
              onPressed: controller.nextButtonEnable.value
                  ? () {
                      controller.navigateToNextPageIfPossible();
                    }
                  : null,
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
      ),
    );
  }

  double _getXOffset(double pageOffset, double width) {
    double xOffset = 0;
    if (pageOffset > 8 && pageOffset <= 9) {
      xOffset = width * 0.4 * (pageOffset - 8);
    }
    return xOffset;
  }
}
