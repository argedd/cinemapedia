
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper{
  static Actor castToEntity(Cast cast){
    return Actor(
      id: cast.id, 
      name: cast.name, 
      profilePath: cast.profilePath != null 
        ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
        : 'https://miro.medium.com/v2/resize:fit:4800/format:webp/1*AC9frN1qFnn-I2JCycN8fw.png',
      character: cast.character
      );
    
  }
}