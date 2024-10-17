import 'package:firebase/workshopScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMentorScreen extends StatefulWidget {
  @override
  _AddMentorScreenState createState() => _AddMentorScreenState();
}

class _AddMentorScreenState extends State<AddMentorScreen> {
  final _formKey = GlobalKey<FormState>();
  String _mentorName = '';
  String _expertise = '';
  String _availability = '';
  String _contactInfo = '';
  String _linkedin = '';
  String _domain = '';
  String _experience = '';
  String _preferredMode = '';

  // Add mentor details to Firestore
  Future<void> addMentor() async {
    try {
      await FirebaseFirestore.instance.collection('mentors').add({
        'mentorName': _mentorName,
        'expertise': _expertise,
        'availability': _availability,
        'contactInfo': _contactInfo,
        'linkedin': _linkedin,
        'domain': _domain,
        'experience': _experience,
        'preferredMode': _preferredMode,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mentor details added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
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
                'Add Mentor Details',
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
                'Mentor Information',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5),
                ),
              ),
              SizedBox(height: 16),
              _buildTextField('Mentor Name', (value) => _mentorName = value!),
              _buildTextField('Expertise', (value) => _expertise = value!),
              _buildTextField('Availability', (value) => _availability = value!),
              _buildTextField('Contact Info', (value) => _contactInfo = value!),
              _buildTextField('LinkedIn Profile', (value) => _linkedin = value!),
              _buildTextField('Domain', (value) => _domain = value!),
              _buildTextField('Years of Experience', (value) => _experience = value!),
              _buildTextField('Preferred Mode (Online/Offline)', (value) => _preferredMode = value!),
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
          await addMentor(); // Call the function to add mentor details
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
