import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;

  const DotsIndicator({
    Key? key,
    required this.dotsCount,
    this.position = 0,
  })  : assert(dotsCount > 0),
        assert(position >= 0),
        assert(
          position < dotsCount,
          "Position must be inferior than dotsCount",
        ),
        super(key: key);

  Widget _buildDot(int index) {
    final isCurrent = index == position;
    final size = isCurrent ? const Size.square(8.0) : const Size.square(4.0);

    return Container(
      width: size.width,
      height: size.height,
      margin: const EdgeInsets.all(3.0),
      decoration: ShapeDecoration(
        color: isCurrent ? Colors.blue : Colors.grey,
        shape: isCurrent ? const CircleBorder() : const CircleBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(dotsCount, _buildDot);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: dotsList,
    );
  }
}
