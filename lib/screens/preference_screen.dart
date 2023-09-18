import 'package:flutter/material.dart';
import 'package:movierecommender/screens/signin_screen.dart';
import 'package:movierecommender/views/home.dart';
import 'package:movierecommender/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String? selectedGenre;
  int? selectedYear; 
  String? selectedMovieOption; 

  final List<String> movieOptions = [
    'most_pop_movies',
    'most_pop_series',
    'top_boxoffice_200',
    'top_rated_english_250',
    'top_rated_lowest_100',
    'top_rated_series_250',
  ];

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: hexStringToColor("232430"),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your movie preferences:",
                style: GoogleFonts.kadwa(
                  fontSize: 20,
                  color: hexStringToColor("DDDEEB"),
                  letterSpacing: 1.100,
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: 324,
                height: 50,
                margin: const EdgeInsets.fromLTRB(44, 10, 44, 20),
                child: DropdownButton<String?>(
                  dropdownColor: hexStringToColor("585969"),
                  value: selectedGenre,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGenre = newValue;
                    });
                  },
                  hint: Text("Genre", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                  items: <DropdownMenuItem<String?>>[
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text("Genre", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    for (String genre in [
                      'Action',
                      'Adult',
                      'Adventure',
                      'Animation',
                      'Biography',
                      'Comedy',
                      'Crime',
                      'Documentary',
                      'Drama',
                      'Family',
                      'Fantasy',
                      'Film-Noir',
                      'Game-Show',
                      'History',
                      'Horror',
                      'Music',
                      'Musical',
                      'Mystery',
                      'News',
                      'Reality-TV',
                      'Romance',
                      'Sci-Fi',
                      'Short',
                      'Sport',
                      'Talk-Show',
                      'Thriller',
                      'War',
                      'Western',
                    ])
                      DropdownMenuItem<String?>(
                        value: genre,
                        child: Text(genre, style: TextStyle(color: hexStringToColor("DDDEEB"))),
                      ),
                  ],
                ),
              ),
              // Dropdown for selecting movie options
              Container(
                width: 324,
                height: 50,
                margin: const EdgeInsets.fromLTRB(44, 10, 44, 20),
                child: DropdownButton<String?>(
                  dropdownColor: hexStringToColor("585969"),
                  value: selectedMovieOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMovieOption = newValue;
                    });
                  },
                  hint: Text("Movie Options", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                  items: <DropdownMenuItem<String?>>[
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text("Movie Options", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    DropdownMenuItem<String?>(
                      value: 'most_pop_movies', 
                      child: Text("Popular Movies", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    DropdownMenuItem<String?>(
                      value: 'most_pop_series', 
                      child: Text("Popular Series", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    DropdownMenuItem<String?>(
                      value: 'top_boxoffice_200', 
                      child: Text("Top Box Office", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    DropdownMenuItem<String?>(
                      value: 'top_rated_english_250', 
                      child: Text("Top Rated", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    DropdownMenuItem<String?>(
                      value: 'top_rated_lowest_100', 
                      child: Text("Top Rated Lowest", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    DropdownMenuItem<String?>(
                      value: 'top_rated_series_250', 
                      child: Text("Top Rated Series", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                  ],
                ),
              ),
              // Dropdown for selecting the year of release
              Container(
                width: 324,
                height: 50,
                margin: const EdgeInsets.fromLTRB(44, 10, 44, 20),
                child: DropdownButton<int?>(
                  dropdownColor: hexStringToColor("585969"),
                  value: selectedYear,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedYear = newValue;
                    });
                  },
                  hint: Text("Year of Release", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                  items: <DropdownMenuItem<int?>>[
                    DropdownMenuItem<int?>(
                      value: null,
                      child: Text("Year of Release", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    ),
                    for (int year in List<int>.generate(2023 - 1900 + 1, (index) => 2023 - index))
                      DropdownMenuItem<int?>(
                        value: year,
                        child: Text(year.toString(), style: TextStyle(color: hexStringToColor("DDDEEB"))),
                      ),
                  ],
                ),
              ),
              SearchButton(context, "Search", selectedGenre, selectedYear, selectedMovieOption),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

Container textField(String text) {
  return Container(
    width: 324,
    height: 50,
    child: TextField(
      cursorColor: hexStringToColor("DDDEEB"),
      style: TextStyle(color: hexStringToColor("DDDEEB")),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: hexStringToColor("DDDEEB")),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: hexStringToColor("121212"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    ),
  );
}

Container SearchButton(BuildContext context, String title, String? selectedGenre, int? selectedYear, String? selectedMovieOption) {
  final buttonTextStyle = TextStyle(
    color: hexStringToColor("494F5A"),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  print('\n\n\nSelected Genre: $selectedGenre, Selected Year: $selectedYear, Selected Movie Option: $selectedMovieOption');
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(44, 10, 44, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    child: ElevatedButton(
      onPressed: () {
        // Navigate to the SearchResultsScreen when the button is pressed
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(
              selectedGenre: selectedGenre,
              selectedYear: selectedYear,
              selectedMovieOption: selectedMovieOption,
            ),
          ),
        );
      },
      child: Text(
        title,
        style: buttonTextStyle,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return hexStringToColor("DDDEEB");
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    ),
  );
}
