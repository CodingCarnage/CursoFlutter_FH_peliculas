import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor_credits.dart';

import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actores_model,.dart';
import 'package:peliculas/src/models/actor_detalles_model.dart';

class PeliculasProvider {
  // Movie ID (Joker) = 475557
  // Actor ID (Joaquin Phoenix) = 73421
  String _apikey = '3b81cd78256d41d568e5bfc9f115f4d5';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List<Pelicula>();

  final StreamController<List<Pelicula>> _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreamController() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final http.Response respuesta = await http.get(url);
    final dynamic decodedData = json.decode(respuesta.body);

    final Peliculas peliculas =
        new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final Uri url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;

    final Uri url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final List<Pelicula> respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);

    _cargando = false;

    return respuesta;
  }

  Future<List<Actor>> getCast(String peliculaId) async {
    final Uri url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final http.Response respuesta = await http.get(url);
    final dynamic decodedData = json.decode(respuesta.body);

    final Cast cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final Uri url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await _procesarRespuesta(url);
  }

  Future<Detalles> getPersonDetails(String actorId) async {
    final Uri url = Uri.https(_url, '3/person/$actorId', {
      'api_key': _apikey,
      'language': _language,
    });

    final http.Response respuesta = await http.get(url);
    final Map decodedData = json.decode(respuesta.body);

    final Detalles actorDetalles = new Detalles.fromJsonMap(decodedData);

    return actorDetalles;
  }

  Future<List<PeliculaAparece>> getPersonCredits(String actorId) async {
    final Uri url = Uri.https(_url, '/person/$actorId/movie_credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final http.Response respuesta = await http.get(url);
    final Map decodedData = json.decode(respuesta.body);

    final ActorCredits actorCredits = new ActorCredits.fromJsonList(decodedData['cast']);

    return actorCredits.items;
  }
}
