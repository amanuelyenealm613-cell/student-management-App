import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.blue,
        actions: [
          // የ ዳርክ እና ላይት ሞድ መቀየሪያ ቁልፍ
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => onThemeChanged(!isDarkMode),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/admin-settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              context,
              'Students',
              Icons.school,
              Colors.blue,
                  () => _showPageDialog(context, 'Students Management'),
            ),
            _buildCard(
              context,
              'Teachers',
              Icons.person_outline,
              Colors.green,
                  () => _showPageDialog(context, 'Teachers Management'),
            ),
            _buildCard(
              context,
              'Classes',
              Icons.menu_book,
              Colors.orange,
                  () => _showPageDialog(context, 'Classes Management'),
            ),
            _buildCard(
              context,
              'Attendance',
              Icons.check_circle_outline,
              Colors.purple,
                  () => _showPageDialog(context, 'Attendance System'),
            ),
            _buildCard(
              context,
              'Exams',
              Icons.assignment_outlined,
              Colors.blue,
                  () => _showPageDialog(context, 'Exams & Marks'),
            ),
            _buildCard(
              context,
              'Settings',
              Icons.settings_outlined,
              Colors.teal,
                  () => Navigator.pushNamed(context, '/admin-settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPageDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('የ $title ገጽ በቅርቡ ሙሉ በሙሉ ይሰራል!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
