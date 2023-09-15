import 'package:flutter/material.dart';
import 'package:movierecommender/views/widgets/movie_card.dart';
import 'package:movierecommender/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movierecommender/screens/signin_screen.dart';
import 'package:movierecommender/models/movie.dart';
import 'package:movierecommender/models/movie.api.dart';

class HomePage extends StatefulWidget {
  final String? selectedGenre;
  final int? selectedYear;
  final String? selectedMovieOption;

  HomePage({
    required this.selectedGenre,
    required this.selectedYear,
    required this.selectedMovieOption,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getMovies(widget.selectedGenre, widget.selectedYear, widget.selectedMovieOption);
  }

  Future<void> getMovies(String? selectedGenre, int? selectedYear, String? selectedMovieOption) async {
    _movies = await MovieApi.getMovies(selectedGenre, selectedYear, selectedMovieOption);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("232430"),
        iconTheme: IconThemeData(color: hexStringToColor("DDDEEB")),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              });
            },
          ),
        ],
      ),
      backgroundColor: hexStringToColor("232430"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  title: _movies[index].title,
                  year: _movies[index].year,
                  thumbnailUrl: _movies[index].image,
                  rating: _movies[index].rating,
                );
              },
            ),
    );
  }
}
