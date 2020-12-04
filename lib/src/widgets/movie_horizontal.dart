import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal(
      {Key key, @required this.peliculas, @required this.siguientePagina})
      : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final PageController _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) siguientePagina();
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index) {
          return _tarjeta(context, peliculas[index]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final Column tarjeta = Column(
      children: <Widget>[
        Hero(
          tag: pelicula.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImage()),
              fit: BoxFit.fill,
              height: 160.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
