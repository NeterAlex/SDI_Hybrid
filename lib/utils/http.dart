import 'package:dio/dio.dart';

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
        options.headers['Authorization'] =
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDUzODA4ODgsImlhdCI6MTcwNTI5NDQ4OCwidXNlcl9pZCI6MSwibmlja25hbWUiOiJcdTViZDJcdTZkNDEifQ.gTi2Iki7UDcG4fpxzZ7csrbfCMFtjt6lNfc121_XOzA';
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          return handler.reject(e);
        }
        return handler.next(e);
      },
    ),
  );
}
