import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/menu_response.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://35.227.151.254/v1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('menu')
  Future<MenuResponse> getMenu();

}
