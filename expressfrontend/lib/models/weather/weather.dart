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
      this.predictability,
      this.theTemp,
      this.visibility,
      this.weatherStateAbbr,
      this.weatherStateName,
      this.windDirection,
      this.windDirectionCompass,
      this.windSpeed});
}

class Weather {
  List<WeatherDetail> consolidatedWeather;
  String title;
  String time;

  Weather(this.consolidatedWeather, this.time, this.title);
}
