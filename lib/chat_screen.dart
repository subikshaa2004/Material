import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String seniorName;

  ChatScreen({required this.seniorName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> messages = [
    {'sender': 'You', 'message': 'Hello! I am interested in your project.'},
    {'sender': 'Senior', 'message': 'Great! Lets discuss the details.'},
  ];

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat with ${widget.seniorName}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3F51B5), // Adjust this to match the theme
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return MessageBubble(
                  sender: message['sender']!,
                  message: message['message']!,
                  isMe: message['sender'] == 'You',
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Color(0xFF3F51B5)), // Typing text color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    style: TextStyle(color: Color(0xFF3F51B5)), // Typing text color
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF3F51B5)), // Typing text color
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      setState(() {
                        messages.add({
                          'sender': 'You',
                          'message': _messageController.text,
                        });
                      });
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  MessageBubble({required this.sender, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: BorderRadius.circular(15.0),
            elevation: 5.0,
            color: isMe ? Color(0xFF3F51B5) : Colors.white, // Use theme color for message bubbles
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}