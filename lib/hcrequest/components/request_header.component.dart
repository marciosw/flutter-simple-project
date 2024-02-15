import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RequestHeader extends StatelessWidget {
  final bool? goBackButton;
  const RequestHeader({
    super.key,
    this.goBackButton,
  });

  @override
  Widget build(BuildContext context) {
    const Color lightsecondary = Color(0xff093a4c);
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        goBackButton == true
            ? Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )),
              )
            : const SizedBox(),
        Text(
          'Health Care',
          maxLines: 1,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 32, fontWeight: FontWeight.w700, color: lightsecondary),
        ),
        Text(
          'Digital',
          maxLines: 1,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 32, fontWeight: FontWeight.w700, color: lightsecondary),
        ),
        Text(
          'Request',
          maxLines: 1,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 32, fontWeight: FontWeight.w400, color: lightsecondary),
        ),
        Center(
          child: SizedBox(
            height: 180,
            child: Wrap(
              children: [
                SvgPicture.asset(
                  'assets/images/ilustrations/ilus-medico-prancheta.svg',
                  width: 300,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
