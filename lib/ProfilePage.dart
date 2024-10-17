import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class User {
  String name;
  String email;
  String workingStatus;
  String course;
  String expertiseDomain;
  String yearOfPassout;
  String description;

  User({
    required this.name,
    required this.email,
    required this.workingStatus,
    required this.course,
    required this.expertiseDomain,
    required this.yearOfPassout,
    required this.description,
  });
}

class UserManager {
  static final UserManager _instance = UserManager._internal();
  User? user;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();
}

final userManager = UserManager();

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _workingStatusController;
  late final TextEditingController _courseController;
  late final TextEditingController _expertiseDomainController;
  late final TextEditingController _yearOfPassoutController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final user = userManager.user;

    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _workingStatusController = TextEditingController(text: user?.workingStatus);
    _courseController = TextEditingController(text: user?.course);
    _expertiseDomainController = TextEditingController(text: user?.expertiseDomain);
    _yearOfPassoutController = TextEditingController(text: user?.yearOfPassout);
    _descriptionController = TextEditingController(text: user?.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _workingStatusController.dispose();
    _courseController.dispose();
    _expertiseDomainController.dispose();
    _yearOfPassoutController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.indigo[300],
      ),
      backgroundColor: Colors.indigo,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfilePicture(),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildSectionHeading('Name'),
                  _buildProfileField('Name', _nameController),
                  SizedBox(height: 16),
                  _buildSectionHeading('Email ID'),
                  _buildProfileField('Email ID', _emailController),
                  SizedBox(height: 16),
                  _buildSectionHeading('Working Status'),
                  _buildProfileField('Working Status', _workingStatusController),
                  SizedBox(height: 16),
                  _buildSectionHeading('Course'),
                  _buildProfileField('Course', _courseController),
                  SizedBox(height: 16),
                  _buildSectionHeading('Expertise Domain'),
                  _buildProfileField('Expertise Domain', _expertiseDomainController),
                  SizedBox(height: 16),
                  _buildSectionHeading('Year of Passout'),
                  _buildProfileField('Year of Passout', _yearOfPassoutController),
                  SizedBox(height: 16),
                  _buildSectionHeading('Description'),
                  _buildProfileField('Description', _descriptionController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile_picture.png'),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              fillColor: Colors.transparent,
            ),
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
