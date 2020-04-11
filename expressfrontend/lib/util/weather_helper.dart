import 'dart:convert';

import 'package:expressfrontend/models/response-message/response_message.dart';
import 'package:expressfrontend/models/weather/weather.dart';
import 'package:expressfrontend/util/storage.dart';

Weather weatherFromJson(dynamic payload) {
  ResponseMessage responseMessage =
      ResponseMessage.fromJSON(json.decode(payload));
  Weather weather = Weather.fromJson(json.decode(responseMessage.data));

  Storage.setValue(weather.title.replaceAll(' ', ''), weather.toJson());

  return weather;
}
