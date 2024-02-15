import 'package:flutter/material.dart';
import 'package:healthcare/hcrequest/home.page.dart';
import 'package:healthcare/hcrequest/services/healthcarerequest.service.dart';
import 'package:healthcare/login/services/login.service.dart';
import 'package:healthcare/service_locator.dart';
import 'package:healthcare/shared/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    this.modoDeSelecao = false,
  }) : super(key: key);

  final bool modoDeSelecao;

  static Future<bool> show(
    BuildContext context, {
    bool modoDeSelecao = false,
  }) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginForm(),
      ),
    );
    return false;
  }

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginService = ServiceLocatorConfig.getIt<ILoginService>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const spaceBetween = SizedBox(
      height: 50,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 30),
          color: Colors.white,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  spaceBetween,
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'e-mail',
                    ),
                  ),
                  spaceBetween,
                  TextField(
                    controller: passController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  spaceBetween,
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: patternGreen,
                        minimumSize:
                            const Size(double.infinity, double.infinity),
                      ),
                      onPressed: () async {
                        final login = usernameController.text;
                        final pass = passController.text;
                        await ServiceLocatorConfig.getIt<
                                IHealthCareRequestService>()
                            .init();
                        loginService.signIn(login, pass).then(
                              (value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const HealthCareRequestHomePage(),
                                ),
                              ),
                            );
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
