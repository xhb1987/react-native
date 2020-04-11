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

  Map toJson() {
    return {
      'air_pressure': this.airPressure,
      'applicable_date': this.applicableDate,
      'humidity': this.humidity,
      'id': this.id,
      'max_temp': this.maxTemp,
      'min_temp': this.minTemp,
      'the_temp': this.theTemp,
      'predictability': this.predictability,
      'visibility': this.visibility,
      'weather_state_abbr': this.weatherStateAbbr,
      'weather_state_name': this.weatherStateName,
      'wind_direction': this.windDirection,
      'wind_direction_compass': this.windDirectionCompass,
      'wind_speed': this.windSpeed
    };
  }
}

class Weather {
  List<WeatherDetail> consolidatedWeather;
  String title;
  String time;
  DateTime updatedTime;

  Weather({this.consolidatedWeather, this.time, this.title, this.updatedTime});

  factory Weather.fromJson(Map<String, dynamic> json) {
    print(json['consolidated_weather'].runtimeType);

    var weatherList =
        List<Map<String, dynamic>>.from(json['consolidated_weather']);

    List<WeatherDetail> consolidatedWeather =
        weatherList.map((weather) => WeatherDetail.fromJson(weather)).toList();
    return new Weather(
        consolidatedWeather: consolidatedWeather,
        title: json['title'],
        time: json['time'] as String,
        updatedTime: json['updatedTime'] != null
            ? DateTime.parse(json['updatedTime'])
            : DateTime.now());
  }

  Map toJson() {
    return {
      'updatedTime': this.updatedTime.toString(),
      'title': this.title,
      'time': this.time,
      'consolidated_weather':
          this.consolidatedWeather.map((WeatherDetail weatherDetail) {
        return weatherDetail.toJson();
      }).toList()
    };
  }
}
