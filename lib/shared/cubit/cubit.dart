import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'status.dart';
import 'package:http/http.dart' as http;

class WeatherCubit extends Cubit<WeatherStatus> {

  WeatherCubit() : super(InitiateWeatherState());

  static WeatherCubit get(BuildContext context) => BlocProvider.of(context);

  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '20c50eeaadae4799a05153539230203';
  late WeatherModel weatherModel;
  bool isTextFieldVisable = false;

  
  void getWeather({required String cityName ,}) async{
    emit(GetWeatherDataLoadingState());

    Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3&aqi=no&alerts=no');
    try{
      http.Response response = await http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      weatherModel = WeatherModel.fromJson(json);
      print(weatherModel.location!.localtime);
      print(weatherModel.location!.name);
      emit(GetWeatherDataSuccessfullyState());
    }catch(e){
      emit(GetWeatherDataErrorState());
      print('there are an error : ${e.toString()}');
    }
  }

  void changeVisibilityOfTextField(bool value){
    isTextFieldVisable = !value;
    emit(ChangeTextFieldVisibilityState());
  }
}