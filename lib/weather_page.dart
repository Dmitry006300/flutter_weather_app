import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/models/wether_model.dart';
import 'package:flutter_weather_app/services/auto_update_timer.dart';
import 'package:flutter_weather_app/services/icon_services.dart';
import 'package:flutter_weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  final weatherService = WeatherService();
  final cityNameController = TextEditingController();
  final autoUpdateTimer = AutoUpdateTimer();
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    fetchWeather();
    autoUpdateTimer.startAutoUpdate(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: cityNameController,
              decoration: const InputDecoration(
                labelText: 'Enter city name in English',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => fetchWeather(),
            ),
            const SizedBox(height: 20),
            if (_weather != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (WeatherIcon.getWeatherIcon(_weather!.condition)
                      .isNotEmpty)
                    SvgPicture.asset(
                      WeatherIcon.getWeatherIcon(_weather!.condition),
                      height: 200,
                      width: 200,
                    )
                  else
                    const Text(
                      'No icon',
                      style: TextStyle(color: Colors.grey),
                    ),
                  Text('City: ${_weather!.cityName}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Temperature: ${_weather!.temperature}°C',
                      style: const TextStyle(fontSize: 20)),
                  Text('Condition: ${_weather!.condition}',
                      style: const TextStyle(fontSize: 20)),
                ],
              )
            else
              const Center(
                child: Text(
                  'No weather data',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchWeather() async {
    String cityName = cityNameController.text.trim();
    if (cityName.isEmpty) {
      cityName = 'Omsk';
    }
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print('Error _fetchWeather: $error');
    }
  }
}
