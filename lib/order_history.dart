import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'theme_provider.dart'; // Import your ThemeProvider class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          home: OrderHistoryScreen(),
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

class OrderHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> orderHistory = [
    {
      'title': 'Tour Package',
      'description': 'Enjoy a week-long tour of cultural landmarks.',
      'date': 'June 12, 2023',
    },
    {
      'title': 'Flight Booking',
      'description': 'Round trip tickets for your upcoming vacation.',
      'date': 'May 28, 2023',
    },
    {
      'title': 'Hotel Reservation',
      'description': 'Booked a deluxe room with a seaside view.',
      'date': 'April 5, 2023',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemCount: orderHistory.length,
        itemBuilder: (context, index) {
          final historyItem = orderHistory[index];
          return _buildHistoryItem(
            context,
            title: historyItem['title']!,
            description: historyItem['description']!,
            date: historyItem['date']!,
          );
        },
      ),
    );
  }

  Widget _buildHistoryItem(
      BuildContext context, {
        required String title,
        required String description,
        required String date,
      }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 16),
      color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[800],
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.cyanAccent,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
