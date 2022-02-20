import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token':
          'pk.eyJ1IjoiYW5jZXJveCIsImEiOiJja2NicGU4cmQxZ3czMzBsY3pwYmIwOGdoIn0.KRWjy8RrbVZYvojakAKxVA'
    });

    super.onRequest(options, handler);
  }
}
