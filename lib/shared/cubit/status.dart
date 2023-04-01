abstract class WeatherStatus {}

class InitiateWeatherState extends WeatherStatus {}

class GetWeatherDataLoadingState extends WeatherStatus {}

class GetWeatherDataSuccessfullyState extends WeatherStatus {}

class GetWeatherDataErrorState extends WeatherStatus {}