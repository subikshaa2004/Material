import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class mentoring extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentoring App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MentoringPage(),
    );
  }
}

class MentoringPage extends StatefulWidget {
  @override
  _MentoringPageState createState() => _MentoringPageState();
}

class _MentoringPageState extends State<MentoringPage> {
  String searchQuery = '';
  final List<Map<String, String>> seniors = [
    {
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'description': 'Expert in AI and Machine Learning with over 10 years of experience.',
      'domain': 'AI',
      'course': 'Computer Science',
    },
    {
      'name': 'Jane Smith',
      'email': 'janesmith@example.com',
      'description': 'Specialist in Web Development with a focus on responsive design.',
      'domain': 'Web Development',
      'course': 'Information Technology',
    },
    {
      'name': 'Alice Brown',
      'email': 'alicebrown@example.com',
      'description': 'Data Scientist with a focus on big data analytics and machine learning.',
      'domain': 'Data Science',
      'course': 'Data Science',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredSeniors = seniors
        .where((senior) =>
    senior['domain']?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                padding: EdgeInsets.only(left: 7, bottom: 30),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Find Your Mentor',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by domain',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final senior = filteredSeniors[index];
                return _buildSeniorCard(senior);
              },
              childCount: filteredSeniors.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeniorCard(Map<String, String> senior) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(
                  senior['name'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(senior['domain'] ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => _showSeniorDetails(context, senior),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  senior['description'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              height: 36,
              width: 80,
              child: ElevatedButton(
                onPressed: () => _startChat(context, senior),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline, color: Colors.black, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'CHAT',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[100],
                  foregroundColor: Colors.black,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ).copyWith(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.indigo[200];
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSeniorDetails(BuildContext context, Map<String, String> senior) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    child: Icon(Icons.person, size: 50),
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  senior['name'] ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(senior['domain'] ?? '', style: TextStyle(fontSize: 18, color: Colors.grey)),
                SizedBox(height: 16),
                Text(senior['description'] ?? ''),
                SizedBox(height: 16),
                Text('Email: ${senior['email'] ?? ''}'),
                Text('Course: ${senior['course'] ?? ''}'),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('CLOSE'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _startChat(context, senior);
                      },
                      child: Text('START CHAT'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startChat(BuildContext context, Map<String, String> senior) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(senior: senior),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final Map<String, String> senior;

  ChatPage({required this.senior});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  void _handleSubmitted(String text) {
    _textController.clear();
    _addMessage(ChatMessage(text: text, isUser: true));
  }

  void _handleImageSent(String imagePath) {
    _addMessage(ChatMessage(imagePath: imagePath, isUser: true));
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _handleImageSent(image.path);
    }
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: _getImage,
          ),
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.senior['name'] ?? ''}'),
        actions: [
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String? text;
  final String? imagePath;
  final bool isUser;

  ChatMessage({this.text, this.imagePath, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser) ...[
            CircleAvatar(child: Text('S')),
            SizedBox(width: 10),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: imagePath != null
                      ? Image.file(
                    File(imagePath!),
                    width: 200,
                    fit: BoxFit.cover,
                  )
                      : Text(text ?? ''),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 10),
            CircleAvatar(child: Text('U')),
          ],
        ],
      ),
    );
  }
}