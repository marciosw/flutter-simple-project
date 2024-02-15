import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:healthcare/hcrequest/services/healthcarerequest.service.dart';
import 'package:healthcare/login/services/login.service.dart';

// ignore: avoid_classes_with_only_static_members
class ServiceLocatorConfig {
  static final ServiceLocatorConfig _singleton =
      ServiceLocatorConfig._internal();

  factory ServiceLocatorConfig() {
    return _singleton;
  }

  ServiceLocatorConfig._internal();

  static final GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    LoginService.serviceLocator(getIt);
    HealthCareRequestService.serviceLocator(getIt);
  }
}
