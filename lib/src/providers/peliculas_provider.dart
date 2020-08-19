import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  
  String apikey = 'bd288bc52a7e3fe71ffed382296d9f15';
  String urlapi = 'api.themoviedb.org';
  String language = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(urlapi, '/3/movie/now_playing', {
      'api_key': apikey,
      'language': language
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares(int page) async {
    final url = Uri.https(urlapi, '/3/movie/popular', {
      'api_key': apikey,
      'language': language,
      'page': page.toString(),
    });
    return await _procesarRespuesta(url);
  }
}