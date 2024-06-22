import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isClickable;

  const RoundedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.shortestSide * 0.125,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.shortestSide * 0.15)),
            padding: const EdgeInsets.all(8.0),
            backgroundColor: isClickable ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
          ),
          onPressed: isClickable ? onPressed : null,
          child: isClickable
              ? Text(text, style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.shortestSide * 0.04))
              : const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
