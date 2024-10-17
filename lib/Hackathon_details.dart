import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HackathonDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> hackathon;

  HackathonDetailsScreen({required this.hackathon});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    hackathon['Hackathon'] ?? 'Project Title',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    hackathon['organisation'] ?? 'Department',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
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
          _buildInfoCard(context),
          SizedBox(height: 20),
          _buildDescriptionSection(),
          SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Information',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F51B5),
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.person, 'Name', hackathon['team'] ?? 'N/A'),
            //_buildInfoRow(Icons.email, 'Email', hackathon['seniorEmail'] ?? 'N/A'),
            _buildInfoRow(Icons.work, 'Status', hackathon['mentor'] ?? 'N/A'),
            _buildInfoRow(Icons.work, 'Project Idea Link:', hackathon['ppt'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF3F51B5), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: title == 'Project Idea Link:'
                ? GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(value);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $value';
                }
              },
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Description',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3F51B5),
          ),
        ),
        SizedBox(height: 12),
        Text(
          hackathon['organisation'] ?? 'No organisation available',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Request sent to ${hackathon['team'] ?? 'N/A'}')),
            );
          },
          child: Text('Request to Join'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF303F9F),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            final teamName = hackathon['team'];
            final chatId = hackathon['Id']; // Ensure that you have a unique ID
            if (teamName != null && chatId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    chatId: hackathon['chatId'] ?? 'defaultChatId', // Provide default value if null
                    teamName: hackathon['team'] ?? 'Unknown Team', // Provide default value if null
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Chat not available.')),
              );
            }
          },
          icon: Icon(Icons.chat),
          label: Text('Chat'),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.9),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            side: BorderSide(color: Color(0xFF303F9F)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
