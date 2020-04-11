class WeatherDetail {
  int id;
  String weatherStateName;
  String weatherStateAbbr;
  String windDirectionCompass;
  String applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  int humidity;
  double visibility;
  int predictability;

  WeatherDetail(
      {this.airPressure,
      this.applicableDate,
      this.humidity,
      this.id,
      this.maxTemp,
      this.minTemp,
      this.theTemp,
      this.predictability,
      this.visibility,
      this.weatherStateAbbr,
      this.weatherStateName,
      this.windDirection,
      this.windDirectionCompass,
      this.windSpeed});

  factory WeatherDetail.fromJson(Map<String, dynamic> json) => WeatherDetail(
      airPressure: json['air_pressure'] as num,
      applicableDate: json['applicable_date'] as String,
      humidity: json['humidity'] as int,
      id: json['id'] as int,
      maxTemp: json['max_temp'] as num,
      minTemp: json['min_temp'] as num,
      theTemp: json['the_temp'] as num,
      predictability: json['predictability'] as int,
      visibility: json['visibility'] as num,
      weatherStateAbbr: json['weather_state_abbr'] as String,
      weatherStateName: json['weather_state_name'] as String,
      windDirection: json['wind_direction'] as num,
      windDirectionCompass: json['wind_direction_compass'] as String,
      windSpeed: json['wind_speed'] as num);
}

class Weather {
  List<WeatherDetail> consolidatedWeather;
  String title;
  String time;

  Weather({this.consolidatedWeather, this.time, this.title});

  factory Weather.fromJson(Map<String, dynamic> json) {
    var weatherList =
        List<Map<String, dynamic>>.from(json['consolidated_weather']);

    List<WeatherDetail> consolidatedWeather =
        weatherList.map((weather) => WeatherDetail.fromJson(weather)).toList();
    return new Weather(
        consolidatedWeather: consolidatedWeather,
        title: json['title'],
        time: json['time']);
  }
}
