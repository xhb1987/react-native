import 'dart:convert';

import 'package:expressfrontend/models/city/city.dart';
import 'package:expressfrontend/models/response-message/response_message.dart';

List<City> cityFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));

  final parsed =
      List<Map<String, dynamic>>.from(json.decode(responseMessage.data));
  List<City> cities = parsed.map((p) => City.fromJSON(p)).toList();

  return cities;
}
