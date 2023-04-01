import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/modules/search/search.dart';
import 'package:weather_app/shared/cubit/cubit.dart';
import 'package:weather_app/shared/cubit/status.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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
        return  Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              ),
            ],
            title: Text(
              'Weather',
            ),
          ),
          body: ConditionalBuilder(
            condition: load,
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                          color: Colors.teal,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cubit.weatherModel.location!.name!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      cubit.weatherModel.location!.localtime!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    cubit.weatherModel.forecast!.forecastday![0].day!.avgtempC!.round().toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 90,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  Text(
                                    cubit.weatherModel.forecast!.forecastday![0].day!.condition!.text!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
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
                                          height: 20,
                                        ),
                                        Text(
                                          cubit.weatherModel.forecast!.forecastday![0].day!.mintempC!.round().toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(
                                        cubit.weatherModel.forecast!.forecastday![0].day!.condition!.text! == 'Sunny'?'assets/images/clear.png':
                                        cubit.weatherModel.forecast!.forecastday![0].day!.condition!.text! == 'Clear'? 'assets/images/clear.png':
                                        cubit.weatherModel.forecast!.forecastday![0].day!.condition!.text! == 'Partly cloudy'? 'assets/images/cloudy.png':
                                        cubit.weatherModel.forecast!.forecastday![0].day!.condition!.text! == 'Patchy rain possible'? 'assets/images/rainy.png':
                                        cubit.weatherModel.forecast!.forecastday![0].day!.condition!.text! == 'Light rain shower'? 'assets/images/rainy.png':
                                            'assets/images/thunderstorm.png',

                                    ),
                                    // Image.network(cubit.weatherModel.forecast!.forecastday![0].day!.condition!.icon! ,height: 40 , width: 40,),
                                    Spacer(),
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
                                          height: 20,
                                        ),
                                        Text(
                                          cubit.weatherModel.forecast!.forecastday![0].day!.maxtempC!.round().toString(),
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
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  Padding(
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
                ],
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
