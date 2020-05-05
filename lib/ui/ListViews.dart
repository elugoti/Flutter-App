import 'package:firstflutter/model/Movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MoviesApp extends StatefulWidget {
  @override
  _MoviesAppState createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  final List<Movie> movies = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies App"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int position) {
            return Stack(
              children: <Widget>[
                getCardWidget(movies[position], context),
                Positioned(
                    top: 10, child: getImageCard(movies[position], context))
              ],
            );
          }),
    );
  }

  Widget getCardWidget(Movie movie, BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 50),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Card(
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 54),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${movie.title}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Rating: ${movie.imdbRating}/10",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Released: ${movie.released}",
                          style: TextStyle(color: Colors.grey)),
                      Text("${movie.runtime}",
                          style: TextStyle(color: Colors.grey)),
                      Text("${movie.rated}",
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailViewPage(
                        movieName: movie.title,
                        movie: movie,
                      )));
        });
  }

  getImageCard(Movie movie, BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(movie.images[0]), fit: BoxFit.cover)),
    );
  }
}

class MovieDetailViewPage extends StatefulWidget {
  final String movieName;
  final Movie movie;

  const MovieDetailViewPage({Key key, this.movieName, this.movie})
      : super(key: key);

  @override
  _MovieDetailViewPageState createState() =>
      _MovieDetailViewPageState(movieName, movie);
}

class _MovieDetailViewPageState extends State<MovieDetailViewPage> {
  final String movieName;
  final Movie movie;

  _MovieDetailViewPageState(this.movieName, this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text("$movieName"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              setTopImage(movie, context),
              setDetails(movie, context)
            ],
          ),
//          child: RaisedButton(
//              child: Text("Go Back"),
//              onPressed: () {
//                Navigator.pop(context);
//              }),
        ),
      ),
    );
  }

  setTopImage(Movie movie, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                movie.images[0],
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                    child: Container(
                        child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 75,
                ))),
              )
            ],
          )
        ],
      ),
    );
  }

  setDetails(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    movie.images[1],
                    width: 100,
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Text(
                    "${movie.year} - ${movie.genre}",
                    style: TextStyle(color: Colors.cyan),
                  ),
                  Text(
                    "${movie.plot}",
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.cyan,fontSize: 12),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
