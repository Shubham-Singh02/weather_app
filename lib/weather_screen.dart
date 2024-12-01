import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/AdditionalInfo.dart';
import 'package:weather_app/ApiKey.dart';
import 'package:weather_app/Forecast_Hours.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
  
}

class _WeatherScreenState extends State<WeatherScreen> {
  
 
  
  Future<Map<String,dynamic>> getweatherdata() async{
    try{
    String cityname='Ghaziabad';
    final res = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=$openWeatherApiKey'

      ),
    );

    final data= jsonDecode(res.body);

    if(data['cod']!='200'){
      throw 'An Unexpected Error Occured';

    }
    return data;
      //(data['list'][0]['main']['temp'])-273.15;
    }catch(e){
      throw e.toString();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
    
          ),
          
        ),
        centerTitle: true,
    
       actions:[
         IconButton(onPressed: (){
          setState(() {
            
          });
         },
          icon: const Icon(Icons.refresh),
          ),
       ],
      ),
    
      body: FutureBuilder(
        future: getweatherdata() , 
        builder: (context, snapshot) {
    
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
    
          };
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          };
    
          final data=snapshot.data!;
    
          double currentTemp= (data['list'][0]['main']['temp'])-273.15;
          currentTemp=double.parse(currentTemp.toStringAsFixed(2));
    
          final currentSky=data['list'][0]['weather'][0]['main'];
          final currentPressure =data['list'][0]['main']['pressure'];
          final currentWind =data['list'][0]['wind']['speed'];
          final currenthumidity =data['list'][0]['main']['humidity'];
    
    
          return Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10,
                    sigmaY: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          
                          children: [
                        
                            Text(
                              '$currentTemp °C',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                        
                             Icon(
                              currentSky=='Clouds'||currentSky=='Rain'? Icons.cloud:Icons.circle,
                              color: Colors.amber[200],
                            size: 70,),
                            const SizedBox(
                              height: 16,
                            ),
                        
                           Text('$currentSky',
                          style: const TextStyle(
                            fontSize: 20,
                          ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        
              const SizedBox(
                height: 20,
              ),
        
               const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Weather Forecast',
                 style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
        
              const SizedBox(
                height: 16,
              ),
        
    
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
    
                  double hourlytemp=((data['list'][index+1]['main']['temp'])-273.15);
                  final finalIcon=data['list'][index+1]['weather'][0]['main'];
                  final hourlytime=DateTime.parse( data['list'][index+1]['dt_txt']);
                  hourlytemp=double.parse(hourlytemp.toStringAsFixed(2));
                    return ForecastHours(
                      time: DateFormat.j().format(hourlytime),
                      temp: '$hourlytemp°C',
                      icon:
                      finalIcon=='Clouds'||finalIcon=='Rain'? 
                      Icons.cloud
                      :Icons.nights_stay,
                      );
                  }
    
                ),
              ),
        
              const SizedBox(
                height: 20,
              ),
        
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Additional Information',
                 style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
        
              const SizedBox(
                height: 16,
              ),
        
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                    AdditionalInfo(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: currenthumidity.toString(),
                   ),
            
                 
            
                  AdditionalInfo(
                    icon: Icons.air,
                    label: 'Wind Speed',
                    value: currentWind.toString(),
                  ),
            
                  
            
                  AdditionalInfo(
                    icon: Icons.beach_access,
                    label: 'Pressure',
                    value: currentPressure.toString(),
                  ),
              ],
            )
        
        
            ],
          ),
        );
        },
      ),
    
    );
  }
}

