//import 'package:firebase/Projects.dart';
import 'package:firebase/ShowMaterialScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "HackathonScreen.dart";
import 'mentoring.dart';
//import 'Projects.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Hub',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(background: Colors.indigo),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo, // Blue background color
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Welcome to Project Hub',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 0, // Space between columns
                  mainAxisSpacing: 0, // Space between rows
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMenuButton(Icons.home, 'Project Hub', () => _navigateTo(context, ShowMaterialScreen())),
                    _buildMenuButton(Icons.computer, 'Hackathon', () => _navigateTo(context, HackathonScreen())),
                    _buildMenuButton(Icons.library_books, 'Materials', () => _navigateTo(context, Home())),
                    _buildMenuButton(Icons.group, 'Mentoring', () => _navigateTo(context, mentoring())),
                    _buildMenuButton(Icons.work, 'Workshops', () => _navigateTo(context, mentoring())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.indigo),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.indigo),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.indigo),
            label: 'Logout',
          ),
        ],
        currentIndex: 0, // Set the default selected index
        onTap: (index) {
          // Handle bottom navigation here if needed
        },
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, Function onPressed) {
    return Container(
      margin: EdgeInsets.all(4.0), // Small margin around each button
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.indigo,
          backgroundColor: Colors.white, // Button text color
          padding: EdgeInsets.all(16), // Larger padding
          textStyle: GoogleFonts.poppins(
            fontSize: 16, // Font size
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: Colors.indigo, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30, // Larger icon size
              color: Colors.indigo, // Icon color
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Handle long text
                style: TextStyle(
                  fontSize: 16, // Ensure text size fits within button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

// Placeholder screens for navigation
class ProjectHubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Hub')),
      body: Center(child: Text('This is the Project Hub screen')),
    );
  }
}


class MaterialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Materials')),
      body: Center(child: Text('This is the Materials screen')),
    );
  }
}

class MentoringScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mentoring')),
      body: Center(child: Text('This is the Mentoring screen')),
    );
  }
}

class WorkshopsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workshops')),
      body: Center(child: Text('This is the Workshops screen')),
    );
  }
}
