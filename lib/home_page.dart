import 'package:firebase/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MaterialsPage.dart';
import 'ProfilePage.dart'; // Import your profile screen
import 'ShowMaterialScreen.dart';
import 'HackathonScreen.dart';
import 'WorkshopsScreen.dart';
import 'mentoring.dart';

void main() {
  runApp(Home());
}

/*class Home extends StatelessWidget {
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
                    _buildMenuButton(Icons.library_books, 'Materials', () => _navigateTo(context, MaterialsScreen())),
                    _buildMenuButton(Icons.group, 'Mentoring', () => _navigateTo(context, MentoringScreen())),
                    _buildMenuButton(Icons.work, 'Workshops', () => _navigateTo(context, WorkshopsScreen())),
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
          if (index == 1) {
            // Replace 'userId' with the actual user ID
            _navigateTo(context, ProfilePage());
          } else if (index == 2) {
            // Handle logout functionality here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Logout functionality not implemented yet.')),
            );
          }
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
}*/
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
      MaterialPageRoute(builder: (context) => WorkshopsScreen()),
    );
  }
  void _showMentoringOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => mentoring()),
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


