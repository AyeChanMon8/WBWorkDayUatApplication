import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/models/user.dart';

abstract class BaseBinding implements Bindings {
  final user = User().obs;
  // ignore: non_constant_identifier_names
  final String token_url = Globals.baseURL + "auth/get_tokens";

  client() async {
    final box = GetStorage();
    Dio dio = new Dio();
    var token = await box.read(Globals.token);
    dio.interceptors.clear();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers["Access-Token"] = token;
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError error) async {
      if (error.response?.statusCode == 403) {
        dio..interceptors.requestLock.lock();
        dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
        var response = await dio.post(token_url,
            options: Options(contentType: "text/html"),
            data: {"username": Globals.username, "password": Globals.password});
        if (response.statusCode == 200) {
          user.value = User.fromJson(response.data);
          box.write(Globals.token, user.value.access_token);
        }
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();
        dio.request(options.path, options: options);
      } else {
        return error;
      }
    }));
    dio.options.baseUrl = Globals.baseURL;
    return dio;
  }
}
