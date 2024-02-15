import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:healthcare/hcrequest/models/HealthCareRequest.model.dart';
import 'package:healthcare/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IHealthCareRequestService {
  Future<void> init();
  Future<List<HealthCareRequestlModel>> getAll();
  Future<bool> save(HealthCareRequestlModel model);
  Future<void> deleteAll();
}

class HealthCareRequestService extends IHealthCareRequestService {
  static void serviceLocator(GetIt getIt) {
    // data sources

    getIt.registerLazySingleton<IHealthCareRequestService>(
      () => HealthCareRequestService(),
    );
  }

  @override
  Future<List<HealthCareRequestlModel>> getAll() async {
    final list = await readFromDataBase();
    return list;
  }

  @override
  Future<bool> save(HealthCareRequestlModel model) async {
    try {
      final dataSet = await readFromDataBase();
      dataSet.add(model);
      await saveInDataBase(dataSet);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveInDataBase(List<HealthCareRequestlModel> list) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString =
          jsonEncode(list.map((model) => model.toJson()).toList());
      prefs.setString(keyHealthCareDb, jsonString);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<HealthCareRequestlModel>> readFromDataBase() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final content = prefs.getString(keyHealthCareDb);
      List<dynamic> jsonList = jsonDecode(content ?? '[]');

      List<HealthCareRequestlModel> list = jsonList
          .map((json) => HealthCareRequestlModel.fromJson(json))
          .toList();
      return list;
    } catch (ex) {
      return [];
    }
  }

  @override
  Future<void> init() async {
    final fields = await readFromDataBase();
    if (fields.isNotEmpty) {
      return;
    }
    await save(HealthCareRequestlModel(
        painList: 'head, back',
        intensity: '7',
        contact: 'Phone',
        message: 'I need help 2',
        date: DateTime.now()));
    await save(HealthCareRequestlModel(
        painList: 'head, back, chest',
        intensity: '4',
        contact: 'Phone',
        message: 'I need help 1',
        date: DateTime.now().add(const Duration(days: -1))));
  }

  @override
  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyHealthCareDb, '[]');
  }
}
