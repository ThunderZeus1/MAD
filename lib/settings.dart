import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Orbitron', // Assuming you have this font added to your project
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
          Divider(),
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
          Divider(),
          _buildSettingsItem(
            icon: Icons.language,
            title: 'Language',
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
            onTap: () {
              // Handle language selection
            },
          ),
          Divider(),
          _buildSettingsItem(
            icon: Icons.info,
            title: 'About',
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
            onTap: () {
              // Handle about section
            },
          ),
          Divider(),
          _buildSettingsItem(
            icon: Icons.logout,
            title: 'Logout',
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
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
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
          title: Text(
            'Confirm Logout',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
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
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login page
              },
              child: Text(
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
