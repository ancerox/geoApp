import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoiYW5jZXJveCIsImEiOiJja2NicGU4cmQxZ3czMzBsY3pwYmIwOGdoIn0.KRWjy8RrbVZYvojakAKxVA';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'language': 'en',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
