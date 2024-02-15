import 'package:flutter/material.dart';
import 'package:healthcare/hcrequest/components/request_header.component.dart';
import 'package:healthcare/hcrequest/components/white_card.component.dart';
import 'package:healthcare/hcrequest/home.page.dart';
import 'package:healthcare/shared/constants.dart';

class AfterRegister extends StatefulWidget {
  const AfterRegister({super.key});

  @override
  _AfterRegisterState createState() => _AfterRegisterState();
}

class _AfterRegisterState extends State<AfterRegister> {
  @override
  Widget build(BuildContext context) {
    final Widget body = SafeArea(
      child: Column(
        children: [
          const RequestHeader(),
          WhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.green.withAlpha(30),
                        )),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green.withAlpha(30),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('REQUEST SUBMITTED SUCCESSFULLY!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 240,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Now wait!\n',
                                          style: TextStyle(
                                            color: Color(0xFF011908),
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            height: 1.43,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'Your information has been sent to the CALL CENTER, which will shortly contact you by (video or telephone: inform the users choice here).\n\n',
                                          style: TextStyle(
                                            color: Color(0xFF011908),
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w400,
                                            height: 1.43,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'Average time to return: 2h\n\n',
                                          style: TextStyle(
                                            color: Color(0xFF011908),
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            height: 1.43,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: patternGreen,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Back to home',
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HealthCareRequestHomePage(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            onTapEvent: () {},
          )
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: body,
      ),
    );
  }

  Widget getTextHalfBold(String normalText, String boldText) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          const TextSpan(text: '\u2022 '),
          TextSpan(text: normalText),
          const TextSpan(text: ' '),
          TextSpan(
            text: boldText,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
