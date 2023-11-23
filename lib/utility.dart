
class WeatherUtils {
  static String getImagePath(String weatherCondition,
      {required int width, required int height}) {
    if (weatherCondition == 'Sunny') {
      return 'assets/icons/sunny.png';
    } else if (weatherCondition == 'Clouds') {
      return 'assets/icons/cloudy.png';
    } else if (weatherCondition == 'Rain') {
      return 'assets/icons/rainy.png';
    } else if (weatherCondition == 'smoke') {
      return 'assets/icons/smoke.png';
    } else if (weatherCondition == 'snow') {
      return 'assets/icons/snow.png';
    } else if (weatherCondition == 'snowy') {
      return 'assets/icons/storm.png'; 
    } else if (weatherCondition == 'storm_with_heavy_rain') {
      return 'assets/icons/storm_with_heavy_rain.png';
    } else if (weatherCondition == 'storm') {
      return 'assets/icons/storm.png';
    } else if (weatherCondition == 'summer') {
      return 'assets/icons/summer.png';
    } else if (weatherCondition == 'sun_behind_rain_cloud') {
      return 'assets/icons/sun_behind_rain_cloud.png';
    } else if (weatherCondition == 'sun') {
      return 'assets/icons/sun.png';
    } else if (weatherCondition == 'thunderstorm') {
      return 'assets/icons/thunderstorm.png';
    } else if(weatherCondition == 'broken_clouds'){
      return 'assets/icons/broken_clouds.png';
    }else if(weatherCondition == 'clear_sky'){
      return 'assets/icons/clear_sky';
    }else if(weatherCondition == 'cloudflare'){
      return 'assets/icons/cloudflare.png';
    }else if(weatherCondition == 'cloudy'){
      return 'assets/icons/cloudy';
    }else if(weatherCondition == 'feels_like'){
      return 'assets/icons/feels_like.png';
    }else if(weatherCondition == 'Clear'){
      return 'assets/icons/clear.png';
    } else {
      return 'assets/icons/default.png';
    }
   
  }
}
