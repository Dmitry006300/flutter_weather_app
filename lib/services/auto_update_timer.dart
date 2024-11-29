import 'dart:async';

import 'package:flutter_weather_app/weather_page.dart';

WeatherPageState? weatherPageState;

class AutoUpdateTimer {
  WeatherPageState? weatherPageState;
  Timer? updateTimer;
  void startAutoUpdate(WeatherPageState state) {
    updateTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      state.fetchWeather();
    });
    print('timer started');
  }
}
