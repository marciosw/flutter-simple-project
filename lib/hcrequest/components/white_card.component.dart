import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final Widget child;
  final Function onTapEvent;
  final double? height;

  const WhiteCard({
    required this.child,
    required this.onTapEvent,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapEvent(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
          bottom: 100,
        ),
        child: Card(
          elevation: 2,
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
