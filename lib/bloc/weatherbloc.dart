import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/repository/weatherrepo.dart';

class WeatherEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class FetchWeather extends WeatherEvent {
  final _city;

  FetchWeather(this._city);

  @override
  List<Object?> get props => [_city];
}

class ResetWeather extends WeatherEvent{

}

class WeatherState extends Equatable{
  @override
  List<Object?> get props => [];
}

class WeatherNotSearched extends WeatherState{

}

class WeatherLoading extends WeatherState{

}

class WeatherLoaded extends WeatherState{
  final _weather;

  WeatherLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherNotLoaded extends WeatherState{

}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if(event is FetchWeather){
      yield WeatherLoading();
      try{
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherLoaded(weather);
      }catch(_){
        yield WeatherNotLoaded();
      }
    }else if(event is ResetWeather){
      yield WeatherNotSearched();
    }
  }
}