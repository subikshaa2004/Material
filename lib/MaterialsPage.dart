import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ProfilePage.dart'; // Import your profile screen
import 'ShowMaterialScreen.dart';
import 'HackathonScreen.dart';
import 'mentoring.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';


class MaterialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materials'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo[900]!, Colors.indigo[700]!, Colors.indigo[500]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedButton(
                context,
                'Upload Materials',
                Icons.upload_file,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => UploadMaterialsPage())),
              ),
              SizedBox(height: 20),
              _buildAnimatedButton(
                context,
                'View Materials',
                Icons.library_books,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMaterialsPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              //onPrimary: Colors.indigo[900],
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 24),
                SizedBox(width: 8),
                Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }
}
Widget _buildTextField(String label, Function(String?) onSaved) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      onSaved: onSaved,
    ),
  );
}

class ViewMaterialsPage extends StatefulWidget {
  @override
  _ViewMaterialsPageState createState() => _ViewMaterialsPageState();
}

class _ViewMaterialsPageState extends State<ViewMaterialsPage> {
  String _selectedDepartment = 'All';
  String _selectedYear = 'All';

  final List<String> _departments = ['All', 'Computer Science', 'Electrical', 'Mechanical', 'Civil'];
  final List<String> _years = ['All', '1st Year', '2nd Year', '3rd Year', '4th Year'];

  // Function to fetch materials from Firestore
  Stream<List<Map<String, dynamic>>> _getMaterials() {
    return FirebaseFirestore.instance.collection('study').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Filter materials based on the selected department and year
  List<Map<String, dynamic>> _filterMaterials(List<Map<String, dynamic>> materials) {
    return materials.where((material) {
      bool yearMatch = _selectedYear == 'All' || material['year'] == _selectedYear;
      bool deptMatch = _selectedDepartment == 'All' || material['department'] == _selectedDepartment;
      return yearMatch && deptMatch;
    }).toList();
  }

  // Function to launch URL (drive link)
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Materials'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filters: Department and Year
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo[900]!, Colors.indigo[700]!],
              ),
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDropdown('Department', _departments, _selectedDepartment, (value) => setState(() => _selectedDepartment = value!)),
                _buildDropdown('Year', _years, _selectedYear, (value) => setState(() => _selectedYear = value!)),
              ],
            ),
          ),
          // Materials List
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _getMaterials(), // Fetching data from Firestore
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No materials found'));
                }

                final materials = _filterMaterials(snapshot.data!); // Filter materials based on selection

                return ListView.builder(
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(material['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text('${material['year']} - ${material['department']}', style: TextStyle(fontSize: 16)),
                            Text('Course: ${material['courseName']}', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => _launchURL(material['driveLink'] ?? ''),
                              child: Text(
                                material['driveLink'] ?? '',
                                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.download, color: Colors.indigo, size: 30),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Downloading material...')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.indigo[900])),
        );
      }).toList(),
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      isExpanded: true,
    );
  }
}


class UploadMaterialsPage extends StatefulWidget {
  @override
  _UploadMaterialsPageState createState() => _UploadMaterialsPageState();
}

class _UploadMaterialsPageState extends State<UploadMaterialsPage> {
  final _formKey = GlobalKey<FormState>();
  String? name, status, dept, year, courseName, driveLink;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  Future<void> _uploadMaterial() async {
    try {
      // Prepare data to be uploaded
      Map<String, dynamic> materialData = {
        'name': name,
        'status': status,
        'department': dept,
        'year': year,
        'courseName': courseName,
        'driveLink': driveLink,
        'uploadedAt': Timestamp.now(), // Add a timestamp for when the material was uploaded
      };

      // Upload the data to Firestore (materials collection)
      await _firestore.collection('study').add(materialData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Material uploaded successfully!')),
      );
      Navigator.pop(context); // Return to previous screen
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading material: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Materials')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo[100]!, Colors.indigo[50]!, Colors.white],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              _buildBubbleTextField('Name', (value) => name = value),
              _buildBubbleTextField('Status', (value) => status = value),
              _buildBubbleTextField('Department', (value) => dept = value),
              _buildBubbleTextField('Year', (value) => year = value),
              _buildBubbleTextField('Course Name', (value) => courseName = value),
              _buildBubbleTextField('Drive Link', (value) => driveLink = value),
              SizedBox(height: 32),
              ElevatedButton(
                child: Text('Submit', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _uploadMaterial(); // Upload the material to Firestore
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBubbleTextField(String label, Function(String?) onSaved) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
          onSaved: onSaved,
        ),
      ),
    );
  }
}
