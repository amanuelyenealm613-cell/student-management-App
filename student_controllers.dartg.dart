import 'package:flutter/material.dart';

class SchoolController extends ChangeNotifier {

  final String _adminPin = "1234";


  String _schoolLogo = "assets/default_logo.png";


  final List<Map<String, String>> _students = [
    {'id': '1', 'name': 'አበበ ከበደ', 'grade': '10B'},
    {'id': '2', 'name': 'አልማዝ ተስፋዬ', 'grade': '12A'},
  ];


  final List<String> _announcements = [
    "ትምህርት ቤት ሰኞ ቀን በ 2:00 ይከፈታል!",
  ];

  // Getters
  String get adminPin => _adminPin;
  String get schoolLogo => _schoolLogo;
  List<Map<String, String>> get students => _students;
  List<String> get announcements => _announcements;


  void updateLogo(String newLogoPath) {
    _schoolLogo = newLogoPath;
    notifyListeners();
  }


  void addStudent(String name, String grade) {
    _students.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'grade': grade,
    });
    notifyListeners();
  }


  void removeStudent(String id) {
    _students.removeWhere((student) => student['id'] == id);
    notifyListeners();
  }


  void addAnnouncement(String message) {
    _announcements.insert(0, message);
    notifyListeners();
  }
}
