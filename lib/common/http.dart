import 'package:dio/dio.dart';
import 'package:sdi_hybrid/common/global.dart';

import 'config.dart';

final dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
));

Future<void> configureDio() async {
  var config = await ConfigHelper.getConfig();
  // Add base url
  dio.options.baseUrl = config.serverUrl;
  // Set jwt interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = "Bearer ${Global.user.jwt}";
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode != 200) {
          return handler.reject(e);
        }
        return handler.next(e);
      },
    ),
  );
}
