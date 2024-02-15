import 'package:flutter/material.dart';
import 'package:healthcare/hcrequest/components/request_header.component.dart';
import 'package:healthcare/hcrequest/components/white_card.component.dart';
import 'package:healthcare/hcrequest/hcrequestdetail/afterregister.page.dart';
import 'package:healthcare/hcrequest/models/HealthCareRequest.model.dart';
import 'package:healthcare/hcrequest/services/healthcarerequest.service.dart';
import 'package:healthcare/service_locator.dart';
import 'package:healthcare/shared/constants.dart';

class HCRequestRegister extends StatefulWidget {
  const HCRequestRegister({super.key});

  @override
  _HCRequestRegisterState createState() => _HCRequestRegisterState();
}

class _HCRequestRegisterState extends State<HCRequestRegister> {
  final healthCareRequestService =
      ServiceLocatorConfig.getIt<IHealthCareRequestService>();
  final _descrController = TextEditingController();
  ValueNotifier<bool> aceitou = ValueNotifier(false);
  ValueNotifier<bool> isloading = ValueNotifier(false);
  double _currentSliderValue = 1;
  late Set<String> _howToBeAttended;
  late Set<String> corpo;
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text('Video'),
    1: Text('Phone')
  };
  final colSpace = const SizedBox(
    height: 8,
  );

  @override
  void initState() {
    _howToBeAttended = <String>{'Video'};
    corpo = <String>{};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )),
            ),
            const RequestHeader(),
            generateWhiteCard(),
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: body,
      ),
    );
  }

  Widget generateWhiteCard() {
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            'Help with symptoms',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            '1. Indicate which part or parts of your body you have/feel any discomfort or if you have any questions, so that we can help you.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 24,
          ),
          colSpace,
          generateBody(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '2. Report the intensity of the pain you are feeling, with 1 being low and 10 being very strong.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 24,
          ),
          generateIntensityIndication(),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10,
                child: Text('0'),
              ),
              Expanded(
                child: Slider(
                  value: _currentSliderValue,
                  max: 10,
                  divisions: 6,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 30,
                child: Text('10'),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            '3. Prefer to be preceded by:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 300,
            child: SegmentedButton(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                    value: 'Video',
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.video_camera_back_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Video')
                      ],
                    )),
                ButtonSegment<String>(
                    value: 'Phone',
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Phone')
                      ],
                    )),
              ],
              selected: _howToBeAttended,
              onSelectionChanged: (newSelection) {
                setState(() {
                  _howToBeAttended = newSelection;
                });
              },
              multiSelectionEnabled: false,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            '4. Briefly describe what you are feeling here:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _descrController,
            decoration: InputDecoration(
              filled: true,
              iconColor: Colors.black.withOpacity(0.6),
              focusColor: Colors.grey,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: Colors.black.withOpacity(0.6),
              ),
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: Colors.black.withOpacity(0.6),
              ),
              fillColor: Colors.white,
              prefixIconColor: Colors.black.withOpacity(0.6),
              suffixIconColor: Colors.black.withOpacity(0.6),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            maxLines: 4,
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 60,
          ),
          Divider(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(
            height: 24,
          ),
          generateNextButton(),
          const SizedBox(
            height: 16,
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
      onTapEvent: () {},
    );
  }

  Widget generateIntensityIndication() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _currentSliderValue = 0;
            });
          },
          child: const Image(
            image: AssetImage('assets/images/padigital/insert_emoticon.png'),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentSliderValue = 2;
            });
          },
          child: const Image(
            image:
                AssetImage('assets/images/padigital/sentiment_satisfied.png'),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentSliderValue = 4;
            });
          },
          child: const Image(
            image: AssetImage('assets/images/padigital/sentiment_neutral.png'),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentSliderValue = 6;
            });
          },
          child: const Image(
              image: AssetImage(
                  'assets/images/padigital/sentiment_dissatisfied.png')),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentSliderValue = 8;
            });
          },
          child: const Image(
              image: AssetImage('assets/images/padigital/mood_bad.png')),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentSliderValue = 10;
            });
          },
          child: const Image(
              image: AssetImage(
                  'assets/images/padigital/sentiment_very_dissatisfied.png')),
        ),
      ],
    );
  }

  Widget generateNextButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: aceitou,
      builder: (context, value, child) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                aceitou.value = !aceitou.value;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                      value: aceitou.value,
                      onChanged: (value) {
                        aceitou.value = value == true;
                      }),
                  const SizedBox(
                    width: 200,
                    child: Text(
                        'I confirm the request for service and the sending of this information to the Central Health Department.'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            aceitou.value
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: patternGreen,
                    ),
                    child: buttonContent(),
                    onPressed: () async {
                      isloading.value = true;
                      //Save here
                      final model = HealthCareRequestlModel(
                          contact: _howToBeAttended.first,
                          intensity: _currentSliderValue.round().toString(),
                          painList: corpo.isNotEmpty ? corpo.join(', ') : '',
                          message: _descrController.text,
                          date: DateTime.now().add(const Duration(days: -1)));
                      await healthCareRequestService.save(model);
                      nextStep();
                    },
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chevron_right_outlined,
                        ),
                        Text(
                          'NEXT',
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
          ],
        );
      },
    );
  }

  Widget buttonContent() {
    return ValueListenableBuilder<bool>(
        valueListenable: isloading,
        builder: (context, value, child) {
          return isloading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chevron_right_outlined,
                    ),
                    Text(
                      'NEXT',
                    ),
                  ],
                );
        });
  }

  Widget generateBody() {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Column(
            children: [
              colSpace,
              getBodyCheckBox('1. Head'),
              colSpace,
              getBodyCheckBox('2. Spine'),
              colSpace,
              getBodyCheckBox('3. Chest'),
              colSpace,
              getBodyCheckBox('4. Arms'),
              colSpace,
              getBodyCheckBox('5. Abdomen'),
              colSpace,
              getBodyCheckBox('6. Hip'),
              colSpace,
              getBodyCheckBox('7. Legs'),
            ],
          ),
        ),
        const SizedBox(
          width: 130,
          child: Image(
              image:
                  AssetImage('assets/images/ilustrations/human-body-psad.png')),
        ),
      ],
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

  Widget getBodyCheckBox(String value) {
    return Row(
      children: [
        Checkbox(
            value: corpo.contains(value),
            onChanged: (bool? newvalue) {
              setState(() {
                if (newvalue == true) {
                  corpo.add(value);
                } else {
                  corpo.remove(value);
                }
              });
            }),
        Text(value),
      ],
    );
  }

  void nextStep() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AfterRegister(),
    ));
  }
}
