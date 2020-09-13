import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ) {
        print('Cargar siguientes peliculas');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: ( context, i) {
          return _tarjeta( context, peliculas[i]);
        },
        //children: _tarjetas(),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${ pelicula.id }-poster';
    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        print('Title pelicula ${ pelicula.title }');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: peliculaTarjeta,
    );
  }

  /* List<Widget> _tarjetas() {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }
   */
}