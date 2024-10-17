import 'package:firebase/login_page.dart';
import 'package:firebase/workshopScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MaterialsPage.dart';
import 'ProfilePage.dart'; // Import your profile screen
import 'ShowMaterialScreen.dart';
import 'HackathonScreen.dart';
import 'WorkshopsScreen.dart';
import 'addMentorScreen.dart';
import 'mentoring.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Hub',
      theme: _isDarkTheme ? _darkTheme : _lightTheme,
      home: MainMenuPage(toggleTheme: _toggleTheme, isDarkTheme: _isDarkTheme),
    );
  }
}

final _lightTheme = ThemeData(
  primarySwatch: Colors.indigo,
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black87, displayColor: Colors.black87),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(color: Colors.indigo),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.indigo,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
);

final _darkTheme = ThemeData(
  primarySwatch: Colors.indigo,
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white, displayColor: Colors.white),
  scaffoldBackgroundColor: Colors.indigo[900],
  appBarTheme: AppBarTheme(color: Colors.indigo[800]),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.indigo[800],
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
);

class MainMenuPage extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkTheme;

  MainMenuPage({required this.toggleTheme, required this.isDarkTheme});

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _scaleAnimations = List.generate(
      5,
          (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.2, (index + 1) * 0.2, curve: Curves.easeOutBack),
        ),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1: // Navigate to Profile screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;

      case 2: // Handle logout logic
        _logout();
        break;

      default:
      // Handle Home tab or other logic (optional)
        break;
    }
  }
  void _logout() {
    // Add your logout logic here (e.g., clear session, redirect to login)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Dismiss dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ); // Navigate to Login screen
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }


  void _showMaterialsOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MaterialsPage()),
    );
  }

  void _showProjectOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShowMaterialScreen()),
    );
  }
  void _showHackathonOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HackathonScreen()),
    );
  }
  void _showWorkshopOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => workshopScreen()),
    );
  }
  void _showMentoringOptions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Are you willing to mentor or do you need guidance?'),
        duration: Duration(seconds: 10), // Keep the snack bar visible for 10 seconds
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
      ),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mentoring Options'),
        content: const Text('Choose an option:'),
        actions: [
          TextButton(
            onPressed:() {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMentorScreen(),
                  ),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for offering to mentor!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Willing to Mentor'),
          ),
          TextButton(
            onPressed: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => mentoringScreen(),
                  ),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Guidance request noted!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Want Guidance'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Hub'),
        leading: IconButton(
          icon: Icon(widget.isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round),
          onPressed: () => widget.toggleTheme(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isDarkTheme
                ? [Colors.indigo[900]!, Colors.indigo[700]!, Colors.indigo[500]!]
                : [Colors.indigo[100]!, Colors.indigo[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Project Hub',
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkTheme ? Colors.white : Colors.indigo[900],
                    shadows: [Shadow(blurRadius: 10.0, color: Colors.black.withOpacity(0.3), offset: Offset(2, 2))],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: EdgeInsets.all(24),
                  children: [
                    _buildAnimatedBubble(0, Icons.home, 'Project Hub',),
                    _buildAnimatedBubble(1, Icons.computer, 'Hackathon'),
                    _buildAnimatedBubble(2, Icons.library_books, 'Materials'),
                    _buildAnimatedBubble(3, Icons.group, 'Mentoring'),
                    _buildAnimatedBubble(4, Icons.work, 'Workshops'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAnimatedBubble(int index, IconData icon, String label) {
    return ScaleTransition(
      scale: _scaleAnimations[index],
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isDarkTheme
                ? [Colors.indigo[400]!, Colors.indigo[600]!]
                : [Colors.indigo[100]!, Colors.indigo[300]!],
          ),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              if (label == 'Materials') {
                _showMaterialsOptions(context);
              }
              else if  (label == 'Mentoring')
                {
                  _showMentoringOptions(context);
                }
              else if  (label == 'Workshops')
              {
                _showWorkshopOptions(context);
              }
              else if  (label == 'Project Hub')
              {
                _showProjectOptions(context);

              }
              else if  (label == 'Hackathon')
              {
                _showHackathonOptions(context);
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$label button tapped')),
                );
              }
            },


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: widget.isDarkTheme ? Colors.white : Colors.indigo[900]),
                SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkTheme ? Colors.white : Colors.indigo[900],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


