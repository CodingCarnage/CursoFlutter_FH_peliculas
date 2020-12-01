import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '3b81cd78256d41d568e5bfc9f115f4d5';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';
  int _popularesPage = 0;
  bool _cargando = false;


  List<Pelicula> _populares = new List<Pelicula>();

  final StreamController<List<Pelicula>>_popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreamController() { 
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta (Uri url) async {
    final http.Response respuesta = await http.get(url);
    final dynamic decodedData = json.decode(respuesta.body);

    final Peliculas peliculas = new Peliculas.fromJsonList(decodedData['results']);
    
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final Uri url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando)
      return [];
    _cargando = true;

    _popularesPage++;

    final Uri url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language,
      'page' : _popularesPage.toString(),
    });

    final List<Pelicula> respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);

    _cargando = false;
    
    return respuesta;
  }
}