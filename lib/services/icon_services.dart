
 class WeatherIcon {

static String getWeatherIcon(String condition) {
    if (condition.toLowerCase().contains('snow')) {
      return 'assets/snow.svg';
    } else if (condition.toLowerCase().contains('rain')) {
      return 'assets/rain.svg';
    } else if (condition.toLowerCase().contains('cloud') || (condition.toLowerCase().contains('overcast')) || (condition.toLowerCase().contains('mist'))) {
      return 'assets/cloud.svg';
    } else if (condition.toLowerCase().contains('clear') || (condition.toLowerCase().contains('sun'))) {
      return 'assets/sun.svg';
       } else {
      return '';
    }
  }
}