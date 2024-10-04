import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Orbitron', // Assuming you have this font added to your project
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make the AppBar transparent for the gradient
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.grey], // Black to ash gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return _buildSettingsItem(
                icon: Icons.brightness_6,
                title: 'Dark Mode',
                trailing: Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                  activeColor: Colors.cyanAccent,
                ),
              );
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.notifications,
            title: 'Notifications',
            trailing: Switch(
              value: true, // Placeholder for your actual state management
              onChanged: (value) {
                // Handle notifications toggle
              },
              activeColor: Colors.cyanAccent,
            ),
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.language,
            title: 'Language',
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
            onTap: () {
              // Handle language selection
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.info,
            title: 'About',
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
            onTap: () {
              // Handle about section
            },
          ),
          const Divider(),
          _buildSettingsItem(
            icon: Icons.logout,
            title: 'Logout',
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.cyanAccent, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      tileColor: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.black87,
          title: const Text(
            'Confirm Logout',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login page
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
          ],
        );
      },
    );
  }
}
