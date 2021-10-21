import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models.dart';
import 'package:weather_icons/weather_icons.dart';
import 'data_service.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({Key? key}) : super(key: key);

  @override
  _WeatherpageState createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {

  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  String city="";
  String temp="";
  String weather="";


  IconData(){
  if(weather=='haze'){
    return WeatherIcons.day_haze;
  }
  else if(weather=='overcast clouds'){
    return WeatherIcons.cloudy;
  }
  else if(this.weather=='light rain'){
    return WeatherIcons.rain;
  }
  else{
    return WeatherIcons.day_sunny;
  }
  }

  BackImg(){
    if(weather=='haze'){
      return "assets/images/haze.jpg";
    }
    else if(weather=='overcast clouds'){
      return "assets/images/cloudy.jpg";
    }
    else if(this.weather=='light rain'){
      return "assets/images/rain.jpg";
    }
    else{
      return "assets/images/clear.jpg";
    }
  }



  late WeatherResponse _response;

  void _search()async{

    final response= await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);

    this.city=_response.cityName.toString();
    this.temp=_response.tempInfo.temperature.toString();
    this.weather=_response.weatherInfo.description.toString();


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(BackImg()),
              fit: BoxFit.cover,
            ),
          ),

          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Icon(IconData(),size: 40,),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  // Image(image: AssetImage('assets/images/login.png'),height: 100,width: 60,),
                  // Image.network(_response.iconUrl),
                  // Image(image: NetworkImage('https://cdn.pixabay.com/photo/2013/04/01/09/22/thunderstorm-98541_1280.png'),height: 60,width: 60,),

                  Text(temp,
                      style: TextStyle(fontSize: 20),
                    ),

                  Text(weather),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),



                  ElevatedButton(
                      onPressed: _search,
                      child: Text('Search'),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


