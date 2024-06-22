import 'package:flutter/material.dart';

class PreviousPageButton extends StatelessWidget {
  const PreviousPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    // final bloc = ResumeMakerBlocProvider.of(context);
    var pageOffset = 0.0;
    return Positioned(
      bottom: 64,
      right: 24,
      child: Transform.translate(
        offset: Offset(-_getXOffset(pageOffset, MediaQuery.of(context).size.width),
            _getYOffset(pageOffset, MediaQuery.of(context).size.height)),
        child: ClipOval(
          child: Container(
              height: 32,
              width: 32,
              color: Theme.of(context).primaryColor,
              child: IconButton(
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                onPressed: () {
                  // bloc.navigateToPreviousPageIfPossible();
                },
                icon: const Icon(Icons.keyboard_arrow_up),
              )),
        ),
      ),
    );
  }

  double _getXOffset(double pageOffset, double width) {
    double xOffset = -width * 0.1;
    if (pageOffset >= 0 && pageOffset <= 1) {
      xOffset = width * 0.4 * (pageOffset - 1);
    } else {
      xOffset = 0;
    }
    return xOffset;
  }

  double _getYOffset(double pageOffset, double height) {
    double yOffset = 0;
    if (pageOffset > 8 && pageOffset <= 9) {
      yOffset = 40 * (pageOffset - 8);
    }
    return yOffset;
  }
}
