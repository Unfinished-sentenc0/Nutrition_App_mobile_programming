import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Welcome Section
              _buildSectionTitle('Welcome to the Help Section'),
              _buildSectionContent(
                'Here you can find information on how to use the app, frequently asked questions, and contact support if needed. We aim to provide a smooth experience and assist you in any way possible.',
              ),
              
              // FAQ Section
              _buildSectionTitle('Frequently Asked Questions'),
              _buildFaqItem(
                'How do I reset my password?',
                'To reset your password, go to the login screen and click on "Forgot Password". Follow the instructions to reset your password via email.',
              ),
              _buildFaqItem(
                'How can I contact support?',
                'You can contact support by navigating to the "Messages" section and sending a message. Alternatively, you can reach us via email at support@healthyapp.com or call us at 0712345678.',
              ),
              
              // Contact Support Section
              _buildSectionTitle('Contact Support'),
              _buildSectionContent(
                'If you need further assistance, please contact our support team. We are here to help you with any issues or questions you may have.',
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactSupportScreen()),
                  );
                },
                child: Text('Contact Support'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey[600],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'For any support inquiries, please send us a message or call us at 0712345678. We strive to respond as quickly as possible.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[600],
              ),
            ),
            SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}
