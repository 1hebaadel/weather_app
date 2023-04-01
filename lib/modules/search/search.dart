import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/status.dart';



class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();
  bool load = false;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit , WeatherStatus>(
      listener: (context, state) {
        if(state is GetWeatherDataSuccessfullyState){
          load = true;
        }
      },
      builder: (context, state) {
        WeatherCubit cubit = WeatherCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Search',
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 16.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Enter City',
                    hintText: 'Enter City',
                  ),
                  onFieldSubmitted: (value){
                    cubit.getWeather(cityName: value);
                  },
                ),
              ),
              ConditionalBuilder(
                condition: load,
                builder: (context) =>  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0 , vertical: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: double.infinity,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            Image.asset(
                              cubit.weatherModel.forecast!.forecastday![index].day!.condition!.text! == 'Sunny'?'assets/images/clear.png':
                              cubit.weatherModel.forecast!.forecastday![index].day!.condition!.text! == 'Clear'? 'assets/images/clear.png':
                              cubit.weatherModel.forecast!.forecastday![index].day!.condition!.text! == 'Partly cloudy'? 'assets/images/cloudy.png':
                              cubit.weatherModel.forecast!.forecastday![index].day!.condition!.text! == 'Patchy rain possible'? 'assets/images/rainy.png':
                              cubit.weatherModel.forecast!.forecastday![index].day!.condition!.text! == 'Light rain shower'? 'assets/images/rainy.png':
                              'assets/images/thunderstorm.png',

                            ),
                            Text(
                              cubit.weatherModel.forecast!.forecastday![index].day!.avgtempC!.round().toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  cubit.weatherModel.forecast!.forecastday![index].date!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'MIN',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          cubit.weatherModel.forecast!.forecastday![index].day!.mintempC!.round().toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'MAX',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          cubit.weatherModel.forecast!.forecastday![index].day!.maxtempC!.round().toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: cubit.weatherModel.forecast!.forecastday!.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5,
                    ),
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}
