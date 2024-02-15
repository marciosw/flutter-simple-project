import 'package:flutter/material.dart';
import 'package:healthcare/hcrequest/hcrequestdetail/afterregister.page.dart';
import 'package:healthcare/hcrequest/home.page.dart';
import 'package:healthcare/hcrequest/services/healthcarerequest.service.dart';
import 'package:healthcare/login/login.page.dart';
import 'package:healthcare/login/services/login.service.dart';
import 'package:healthcare/service_locator.dart';

class AlphaPage extends StatelessWidget {
  const AlphaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: const InitialPAge(),
    );
  }
}

class InitialPAge extends StatefulWidget {
  const InitialPAge({super.key});

  @override
  InitialPAgeState createState() {
    return InitialPAgeState();
  }
}

class InitialPAgeState extends State<InitialPAge> with WidgetsBindingObserver {
  final loginService = ServiceLocatorConfig.getIt<ILoginService>();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  verifyLogin(BuildContext context) async {
    loginService.isLogged().then((logged) {
      if (logged) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HealthCareRequestHomePage(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginForm(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    verifyLogin(context);
    return const Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: CircularProgressIndicator(),
          ),
          //verify(),
        ],
      )),
    );
  }
}
