import 'package:ai_studio_client/models/Movie.dart';
import 'package:ai_studio_client/store/GameState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSelectPage extends StatefulWidget {
  const MovieSelectPage({super.key});

  @override
  State<MovieSelectPage> createState() => _MovieSelectPageState();
}

class _MovieSelectPageState extends State<MovieSelectPage> {
  Movie? selectedMovie = null;

  void _goToPerformerSelectScreen() {
    if (selectedMovie != null) {
      Provider.of<GameState>(context, listen: false)
          .setCurrentMovie(selectedMovie!);
      Navigator.pushNamed(context, '/performers');
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Provider.of<GameState>(context, listen: false)
        .getMovies()
        .then((movies) => {
              if (movies == null) {Navigator.pushReplacementNamed(context, '/')}
            });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("Select Movie"),
            automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 400),
                  margin: const EdgeInsets.only(top: 25, left: 24, right: 24),
                  child:
                      Consumer<GameState>(builder: (context, provider, child) {
                    return FutureBuilder<List<Movie>?>(
                      future: provider.getMovies(),
                      builder: (context, snapshot) {
                        List<Widget> children = <Widget>[
                          CircularProgressIndicator()
                        ];

                        if (snapshot.hasData && snapshot.data != null) {
                          children = snapshot.data!
                              .map((movie) => RadioListTile(
                                    title: Text(
                                        "${movie.name} - ${movie.synopsis}"),
                                    value: movie,
                                    groupValue: selectedMovie,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedMovie = movie;
                                      });
                                    },
                                  ))
                              .toList();
                        } else if (snapshot.hasError) {
                          children = <Widget>[Text('${snapshot.error}')];
                        }

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ),
                        );
                      },
                    );
                  }))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _goToPerformerSelectScreen,
          tooltip: 'Select',
          child: const Text('Next'),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}