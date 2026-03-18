import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY PROFILE', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w400, fontSize: 13)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF121212),
                child: Icon(Icons.person, size: 50, color: Color(0xFFDC143C)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, letterSpacing: 1),
            ),
            const Text(
              'Member since March 2026',
              style: TextStyle(color: Color(0x3DFDFBD4), fontSize: 12, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 32),
            _buildProfileOption(context, Icons.person_outline, 'Personal Details'),
            _buildProfileOption(context, Icons.notifications_none, 'Notifications'),
            _buildProfileOption(context, Icons.security, 'Security'),
            _buildProfileOption(context, Icons.help_outline, 'Help & Support'),
            const SizedBox(height: 32),
            _buildProfileOption(context, Icons.logout, 'Logout', isDestructive: true),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFFDFBD4).withOpacity(0.05)),
      ),
      child: ListTile(
        leading: Icon(icon, color: isDestructive ? Colors.redAccent : const Color(0xFFDC143C)),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.redAccent : Color(0xB3FDFBD4),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0x3DFDFBD4), size: 20),
        onTap: () {
          if (isDestructive) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else {
            // Other options
          }
        },
      ),
    );
  }
}
