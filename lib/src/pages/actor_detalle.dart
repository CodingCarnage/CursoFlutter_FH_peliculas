import 'package:flutter/material.dart';

import 'package:peliculas/src/models/actores_model,.dart';
import 'package:peliculas/src/models/actor_credits.dart';
import 'package:peliculas/src/models/actor_detalles_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class ActorDetalle extends StatelessWidget {
  const ActorDetalle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personas',
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                _actorDetalle(actor),
                SizedBox(height: 30.0),
                _actorApareceEn(actor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _actorDetalle(Actor actor) {
    final PeliculasProvider peliculasProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculasProvider.getPersonDetails(actor.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return Column(
            children: <Widget>[
              _crearActorDetalles(snapshot.data, context),
              SizedBox(height: 20.0),
              _biografiaActor(snapshot.data),
            ],
          );
        else
          return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      },
    );
  }

  Widget _crearActorDetalles(Detalles detalles, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          // --- Imagen de actor con Hero ---
          Hero(
            tag: detalles.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(detalles.getFoto()),
                height: 150.0,
                width: 105.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // --- Algunos datos del actor ---
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    detalles.name,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    detalles.placeOfBirth != null
                        ? detalles.placeOfBirth
                        : 'N/A',
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.favorite_border),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.5),
                        child: Text(
                          detalles.popularity != null
                              ? detalles.popularity.toString()
                              : 'N/A',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _biografiaActor(Detalles detalles) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        detalles.biography,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _actorApareceEn(Actor actor) {
    final PeliculasProvider peliculasProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculasProvider.getPersonCredits(actor.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return _apareceEnPageView(snapshot.data, context);
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _apareceEnPageView(List<PeliculaAparece> peliculaAparece, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
          child: Text(
            'Aparece en',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: 175.0,
          child: PageView.builder(
            pageSnapping: false,
            controller: PageController(
              viewportFraction: 0.3,
              initialPage: 1,
            ),
            itemCount: peliculaAparece.length,
            itemBuilder: (context, index) =>
                _peliculaAparaceTarjeta(peliculaAparece[index], context),
          ),
        ),
      ],
    );
  }

  Widget _peliculaAparaceTarjeta(PeliculaAparece peliculaAparece, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(peliculaAparece.getPosterImage()),
              height: 148.4,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            peliculaAparece.title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
