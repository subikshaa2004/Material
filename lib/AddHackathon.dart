import 'package:firebase/HackathonScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ShowMaterialScreen.dart'; // Import your ShowMaterialScreen

class AddHackathonScreen extends StatefulWidget {
  @override
  _AddHackathonScreenState createState() => _AddHackathonScreenState();
}

class _AddHackathonScreenState extends State<AddHackathonScreen> {
  final _formKey = GlobalKey<FormState>();
  String _Hackathon = '';
  String _Organisation = '';
  String _problemStatement = '';
  String _team = '';
  String _projectGit = '';
  String _domain = '';
  String _year = '';
  String _mentor = '';
  String _ppt='';
  String _Id='';
  String _teamId='';// Corrected typo: changed from ' ' to ''

  // Add material to Firestore
  Future<void> addHackathon() async {
    try {
      await FirebaseFirestore.instance.collection('hackathon').add({
        'Hackathon': _Hackathon,
        'Organisation': _Organisation,
        'problemStatement': _problemStatement,
        'team': _team,
        'projectGit': _projectGit,
        'domain': _domain,
        'mentor': _mentor,
        'year': _year,
        'ppt':_ppt,
        'Id':_Id,
        'teamTd':_teamId,
        'timestamp': FieldValue.serverTimestamp()
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hackathon added successfully')));

      // Navigate to ShowMaterialScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HackathonScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3F51B5), Color(0xFF303F9F)],
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -50,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Text(
                'Add Hackathon',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildForm(),
          SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Material Information',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5),
                ),
              ),
              SizedBox(height: 16),
              _buildTextField('Hackathon', (value) => _Hackathon = value!),
              _buildTextField('Organisation', (value) => _Organisation = value!),
              _buildTextField('Problem Statement', (value) => _problemStatement = value!),
              _buildTextField('Team members', (value) => _team = value!),
              _buildTextField('Project Git Hub Link', (value) => _projectGit = value!),
              _buildTextField('Domain', (value) => _domain = value!),
              _buildTextField('Mentor', (value) => _mentor = value!),
              _buildTextField('Year', (value) => _year = value!),
              _buildTextField('Project Idea ppt', (value) => _ppt = value!),
              // Corrected label to 'Year'
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: onSaved,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          await addHackathon(); // Call the function to add material
        }
      },
      child: Text('Submit'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF303F9F),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}