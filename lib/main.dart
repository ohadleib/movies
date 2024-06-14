// ייבוא חבילה Flutter 
import 'package:flutter/material.dart';

// ייבוא קובץ המסך הראשי
import 'screen/home_screen.dart';

// פונקציית main שמריצה את האפליקציה
void main() {
  // הפעלת האפליקציה MyApp
  runApp(const MyApp());
}

// מחלקת MyApp שמרחיבה את StatelessWidget
class MyApp extends StatelessWidget {
  // בנאי המחלקה
  const MyApp({super.key});

  // יצירת הווידג'ט הראשי של האפליקציה
  @override
  Widget build(BuildContext context) {
    // החזרת ווידג'ט MaterialApp
    return const MaterialApp(
      // הסרת הבאנר של מצב הדיבאג
      debugShowCheckedModeBanner: false,
      // הגדרת HomeScreen כמסך הראשי
      home: HomeScreen(),
    );
  }
}
