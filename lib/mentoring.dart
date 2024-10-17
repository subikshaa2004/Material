//import 'package:firebase/mentoring_details.dart';
import 'package:firebase/add_project_screen.dart';
import 'package:firebase/project_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'mentoring_details.dart';
import 'addMentorScreen.dart';

class mentoringScreen extends StatefulWidget {
  @override
  _mentoringScreenState createState() => _mentoringScreenState();
}

class _mentoringScreenState extends State<mentoringScreen> {
  String searchQuery = '';
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';
  String? _userProfilePic;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data on page load
  }

  Future<void> _fetchUserData() async {
    try {
      // Assuming user is logged in via FirebaseAuth and you have userId
      String userId = FirebaseAuth.instance.currentUser!.uid; // Get current user ID

      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        // Get user details from Firestore document
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _userName = userData['Name'] ?? 'No Name';
          _userEmail = userData['email'] ?? 'No Email';
          _userProfilePic = userData['profilePic'] ?? 'assets/default_profile_pic.jpg'; // Optional: Add default image
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Hub',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(214, 193, 184, 184),
      ),
      drawer: _buildDrawer(), // Integrating the drawer here
      body: Container(
        color: Colors.indigo, // Change background color to blue
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover mentors',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildSearchBar(),
                    SizedBox(height: 8),
                    _buildCategoryBar(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 0),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('mentors')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No mentors added yet.'));
                    }

                    // Filter the list based on search query
                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      final title = doc['mentorName'].toString().toLowerCase();
                      return title.contains(searchQuery.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        final material = filteredDocs[index];
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    material['mentorName'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    material['contactInfo'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Expertise: ${material['domain']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Year of experience: ${material['experience']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(), // FloatingActionButton for adding new mentorings
    );
  }

  // Floating Action Button
  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMentorScreen(),
          ),
        );
      },
      icon: Icon(Icons.add),
      label: Text('New mentoring'),
      backgroundColor: Color(0xFF303F9F),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search mentors...',
          prefixIcon: Icon(Icons.search, color: Colors.white70),
          suffixIcon: Icon(Icons.mic, color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          hintStyle: GoogleFonts.poppins(color: Colors.white70),
        ),
        style: GoogleFonts.poppins(color: Colors.white),
      ),
    );
  }

  // Category Bar
  Widget _buildCategoryBar() {
    List<String> categories = ['All', 'AI', 'IoT', 'Mobile', 'Web', 'Blockchain'];
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {
                // Handle category filtering here
              },
              child: Text(categories[index]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Drawer Implementation
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white.withOpacity(0.9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF3F51B5).withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: _userProfilePic != null
                        ? NetworkImage(_userProfilePic!) // If image URL is from network
                        : AssetImage('assets/default_profile_pic.jpg') as ImageProvider, // Default local image
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _userName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    _userEmail,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.person, 'Profile'),
            _buildDrawerItem(Icons.settings, 'Settings'),
            _buildDrawerItem(Icons.info_outline, 'About Us'),
            _buildDrawerItem(Icons.logout, 'Logout', onTap: () async {
              await FirebaseAuth.instance.signOut(); // Logout logic
              Navigator.pushReplacementNamed(context, '/login'); // Navigate back to login screen
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3F51B5)),
      title: Text(title, style: const TextStyle(color: Color(0xFF3F51B5))),
      onTap: onTap ?? () {}, // Handle drawer item tap here
    );
  }
}
