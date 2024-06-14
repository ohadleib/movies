// ייבוא חבילות
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/model.dart';

// מפתח ה-API
const apiKey = "c255fd65c6d02cd0f1281703efc9cd61";

// מחלקת APIservices
class APIservices {
  // כתובות ה-API עבור סרטים שמוצגים כעת, שיגיעו בקרוב, וסרטים פופולריים
  final nowShowingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  
  // פונקציה לקבלת סרטים שמוצגים כעת
  Future<List<Movie>> getNowShowing() async {
    // יצירת URL
    Uri url = Uri.parse(nowShowingApi);
    // שליחת בקשה ל-API
    final response = await http.get(url);

    // בדיקת קוד החזרה
    if (response.statusCode == 200) {
      // ניתוח התשובה והמרתה לרשימת סרטים
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // פונקציה לקבלת סרטים שיגיעו בקרוב
  Future<List<Movie>> getUpComing() async {
    // יצירת URL
    Uri url = Uri.parse(upComingApi);
    // שליחת בקשה ל-API
    final response = await http.get(url);

    // בדיקת קוד החזרה
    if (response.statusCode == 200) {
      // ניתוח התשובה והמרתה לרשימת סרטים
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  // פונקציה לקבלת סרטים פופולריים
  Future<List<Movie>> getPopular() async {
    // יצירת URL
    Uri url = Uri.parse(popularApi);
    // שליחת בקשה ל-API
    final response = await http.get(url);

    // בדיקת קוד החזרה
    if (response.statusCode == 200) {
      // ניתוח התשובה והמרתה לרשימת סרטים
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
