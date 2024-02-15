import 'package:get_it/get_it.dart';
import 'package:healthcare/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class ILoginService {
  Future<bool> signIn(String login, String pass);
  Future<bool> isLogged();
  Future<bool> logout();
}

class LoginService extends ILoginService {
  static void serviceLocator(GetIt getIt) {
    // data sources

    getIt.registerLazySingleton<ILoginService>(
      () => LoginService(),
    );
  }

  @override
  Future<bool> signIn(String login, String pass) async {
    final token = const Uuid().v4();
    await setToken(token);
    return true;
  }

  @override
  Future<bool> isLogged() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<bool> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.remove(keyAccessToken);
    } catch (ex) {
      return false;
    }
  }

  Future<bool> setToken(String accessToken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(keyAccessToken, accessToken);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<String?> getToken() async {
    String? accessToken;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString(keyAccessToken);
      return accessToken;
    } catch (ex) {
      return null;
    }
  }
}

class EmpresaEmail {
  EmpresaEmail({
    this.id,
    this.nome,
    this.userName,
  });
  int? id;
  String? nome;
  String? userName;
}

class VerifyEmailResult {
  VerifyEmailResult({this.success, this.message, this.empresas});
  bool? success;
  String? message;
  List<EmpresaEmail>? empresas;
}
