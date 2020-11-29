import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '3b81cd78256d41d568e5bfc9f115f4d5';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  Future<List<Pelicula>> getEnCines() async {
    final Uri url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language,
    });

    final http.Response respuesta = await http.get(url);
    final dynamic decodedData = json.decode(respuesta.body);

    final Peliculas peliculas = new Peliculas.fromJsonList(decodedData['results']);
    
    return peliculas.items;
  }
}