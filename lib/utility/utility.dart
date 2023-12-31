
class WeatherUtils {
  static String getImagePath(String weatherCondition,
      {required int width, required int height}) {
    if (weatherCondition == 'sunny') {
      return 'assets/icons/sunny.png';
    } else if (weatherCondition == 'Clouds') {
      return 'assets/icons/cloudy.png';
    } else if (weatherCondition == 'Rain') {
      return 'assets/icons/rain.png';
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
      return 'assets/icons/clear_sky.png';
    }else if(weatherCondition == 'cloudflare'){
      return 'assets/icons/cloudflare.png';
    }else if(weatherCondition == 'cloudy'){
      return 'assets/icons/cloudy.png';
    }else if(weatherCondition == 'feels_like'){
      return 'assets/icons/feels_like.png';
    }else if(weatherCondition == 'Clear'){
      return 'assets/icons/clear.png';
    } else if(weatherCondition == 'Mist'){
      return 'assets/icons/mist.png';
    }else if(weatherCondition == 'foggy'){
      return 'assets/icons/foggy.png' ;
    }else if(weatherCondition == 'hail'){
      return 'assets/icons/hail.png' ;
    }else if(weatherCondition == 'haze'){
      return 'assets/icons/haze.png' ;
    }else if(weatherCondition == 'overcast_mist'){
      return 'assets/icons/overcast_mist.png' ;
    }else if(weatherCondition == 'rain'){
      return 'assets/icons/rain.png' ;
    }else if(weatherCondition == 'rain_cloud'){
      return 'assets/icons/rain_cloud.png' ;
    }else if(weatherCondition == 'rainbow'){
      return 'assets/icons/rainbow.png' ;
    }else if(weatherCondition == 'rainfall'){
      return 'assets/icons/rainfall.png' ;
    }else if(weatherCondition == 'sky'){
      return 'assets/icons/sky.png' ;
    }else if(weatherCondition == 'raindrop'){
      return 'assets/icons/raindrop.png' ;
    }else if(weatherCondition == 'moisture'){
      return 'assets/icons/moisture.png' ;
    } else {
      return 'assets/icons/default.png';
    }
  }
}
