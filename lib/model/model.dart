// מחלקת Movie
class Movie {
  // מאפייני המחלקה
  final String title;
  final String backDropPath;

  // בנאי המחלקה
  Movie({
    required this.title,
    required this.backDropPath,
  });

  // פונקציה ליצירת אובייקט Movie ממפה
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      backDropPath: map['backdrop_path'],
    );
  }

  // פונקציה להמרת אובייקט Movie למפה
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'backDropPath': backDropPath,
    };
  }
}
