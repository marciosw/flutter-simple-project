import 'package:flutter/material.dart';
import 'package:healthcare/hcrequest/home.page.dart';
import 'package:healthcare/hcrequest/services/healthcarerequest.service.dart';
import 'package:healthcare/login/login.page.dart';
import 'package:healthcare/login/services/login.service.dart';
import 'package:healthcare/service_locator.dart';
import 'package:healthcare/shared/constants.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({super.key});
  final loginService = ServiceLocatorConfig.getIt<ILoginService>();
  final healthCareRequestService =
      ServiceLocatorConfig.getIt<IHealthCareRequestService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: patternGreen,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: const BoxDecoration(
                  color: patternGreen,
                ),
                child: const Text(
                  'Health Care',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HealthCareRequestHomePage(),
                    ),
                  )
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sair'),
                onTap: () async {
                  await loginService.logout();
                  await healthCareRequestService
                      .deleteAll()
                      .then((value) => backToLogin(context));
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void backToLogin(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginForm(),
      ),
    );
  }
}
