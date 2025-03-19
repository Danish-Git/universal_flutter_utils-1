import 'dart:io';
import 'package:dio/dio.dart';
import 'package:universal_flutter_utils/universal_flutter_utils.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Check internet connection
    String? token = await UFUtils.preferences.readAuthToken();
    bool isConnected = await _checkInternetConnection();
    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No Internet connection',
          type: DioExceptionType.connectionError,
        ),
      );
    }

    // Add headers
    options.headers['Authorization'] = 'Bearer ${token ?? ""}';
    options.headers['Content-Type'] = 'multipart/form-data';
    print('Request: ${options.method} ${options.path}');
    return handler.next(options);
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
