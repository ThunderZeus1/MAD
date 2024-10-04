import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'theme_provider.dart'; // Import your ThemeProvider class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          home: const NotificationsScreen(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.grey[200],
            // Light mode background color
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.grey[900],
            // Dark mode background color
          ),
          themeMode: themeProvider.themeMode,
          // Use 'ThemeMode.dark' for always dark mode
        ),
      ),
    ),
  );
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          _buildNotificationItem(
            icon: Icons.info_outline,
            title: 'Update on Booking',
            description: 'Your booking details have been updated.',
            time: '2 hours ago',
            context: context,
          ),
          const SizedBox(height: 20),
          _buildNotificationItem(
            icon: Icons.local_offer,
            title: 'Special Offer',
            description: 'New offers available for your next travel destination.',
            time: '5 hours ago',
            context: context,
          ),
          const SizedBox(height: 20),
          _buildNotificationItem(
            icon: Icons.event_available,
            title: 'Event Reminder',
            description: 'Don\'t miss the cultural event you booked.',
            time: '1 day ago',
            context: context,
          ),
          const SizedBox(height: 20),
          _buildNotificationItem(
            icon: Icons.payment,
            title: 'Payment Confirmation',
            description: 'Your payment for the tour package has been received.',
            time: '3 days ago',
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
    required BuildContext context,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[800],
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          icon,
          size: 36,
          color: Colors.blueAccent, // Accent color for icons
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.cyanAccent, // Adjusted for light and dark modes
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
