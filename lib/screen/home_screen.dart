// ייבוא חבילות
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Model/model.dart';
import '../services/services.dart';

// מחלקת HomeScreen שמרחיבה את StatefulWidget
class HomeScreen extends StatefulWidget {
  // בנאי המחלקה
  const HomeScreen({super.key});

  // יצירת State עבור HomeScreen
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// מחלקת _HomeScreenState שמרחיבה את State<HomeScreen>
class _HomeScreenState extends State<HomeScreen> {
  // משתנים עבור סרטים שמוצגים כעת, שיגיעו בקרוב, וסרטים פופולריים
  late Future<List<Movie>> nowShowing;
  late Future<List<Movie>> upComing;
  late Future<List<Movie>> popularMovies;

  // אתחול ה-State
  @override
  void initState() {
    // קריאת API עבור סרטים שמוצגים כעת
    nowShowing = APIservices().getNowShowing();
    // קריאת API עבור סרטים שיגיעו בקרוב
    upComing = APIservices().getUpComing();
    // קריאת API עבור סרטים פופולריים
    popularMovies = APIservices().getPopular();
    // קריאה לפונקציית initState של המחלקה האב
    super.initState();
  }

  // בניית הווידג'ט של המסך
  @override
  Widget build(BuildContext context) {
    // יצירת Scaffold
    return Scaffold(
      // יצירת AppBar
      appBar: AppBar(
        // כותרת ה-AppBar
        title: const Text("Movei App"),
        // אייקון תפריט בצד שמאל
        leading: const Icon(Icons.menu),
        // כותרת ממורכזת
        centerTitle: true,
        // פעולות נוספות ב-AppBar
        actions: const [
          // אייקון חיפוש
          Icon(Icons.search_rounded),
          // רווח של 20 פיקסלים
          SizedBox(width: 20),
          // אייקון התראות
          Icon(Icons.notifications),
          // רווח של 10 פיקסלים
          SizedBox(width: 10),
        ],
      ),
      // גוף ה-Scaffold
      body: SingleChildScrollView(
        // ריווח פנימי
        child: Padding(
          padding: const EdgeInsets.all(8),
          // יצירת Column עם מספר ווידג'טים
          child: Column(
            // יישור ווידג'טים להתחלה
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // טקסט "Now Showing"
              const Text(
                "  Now Showing",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              // רווח של 10 פיקסלים
              const SizedBox(height: 10),
              // FutureBuilder עבור nowShowing
              FutureBuilder(
                future: nowShowing,
                builder: (context, snapshot) {
                  // בדיקה אם אין נתונים עדיין
                  if (!snapshot.hasData) {
                    return const Center(
                      // הצגת מעגל טעינה
                      child: CircularProgressIndicator(),
                    );
                  }
                  // קבלת רשימת הסרטים
                  final movies = snapshot.data!;
                  // יצירת CarouselSlider עם הסרטים
                  return CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index, movieIndex) {
                      // קבלת הסרט הנוכחי
                      final movie = movies[index];
                      // יצירת Stack עם תמונת הרקע וכותרת הסרט
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // הצגת כותרת הסרט
                          Positioned(
                            bottom: 15,
                            left: 0,
                            right: 0,
                            child: Text(
                              movie.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    // אפשרויות עבור ה-CarouselSlider
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1.7,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                  );
                },
              ),
              // רווח של 20 פיקסלים
              const SizedBox(height: 20),
              // טקסט "Up Coming Movies"
              const Text(
                "  Up Coming Movies",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              // יצירת מיכל עבור הסרטים שיגיעו בקרוב
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 250,
                // FutureBuilder עבור upComing
                child: FutureBuilder(
                  future: upComing,
                  builder: (context, snapshot) {
                    // בדיקה אם אין נתונים עדיין
                    if (!snapshot.hasData) {
                      return const Center(
                        // הצגת מעגל טעינה
                        child: CircularProgressIndicator(),
                      );
                    }
                    // קבלת רשימת הסרטים
                    final movies = snapshot.data!;
                    // יצירת ListView עם הסרטים
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          // קבלת הסרט הנוכחי
                          final movie = movies[index];
                          // יצירת Stack עם תמונת הרקע וכותרת הסרט
                          return Stack(
                            children: [
                              Container(
                                width: 180,
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                               // הצגת כותרת הסרט
                               Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
              // רווח של 10 פיקסלים
               const SizedBox(height: 10),
              // טקסט "Popular Movies"
              const Text(
                "  Popular Movies",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              // יצירת מיכל עבור הסרטים הפופולריים
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                // FutureBuilder עבור popularMovies
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    // בדיקה אם אין נתונים עדיין
                    if (!snapshot.hasData) {
                      return const Center(
                        // הצגת מעגל טעינה
                        child: CircularProgressIndicator(),
                      );
                    }
                    // קבלת רשימת הסרטים
                    final movies = snapshot.data!;
                    // יצירת ListView עם הסרטים
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          // קבלת הסרט הנוכחי
                          final movie = movies[index];
                          // יצירת Stack עם תמונת הרקע וכותרת הסרט
                          return Stack(
                            children: [
                              Container(
                                width: 180,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // הצגת כותרת הסרט
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
