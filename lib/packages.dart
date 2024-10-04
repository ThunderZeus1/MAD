import 'package:flutter/material.dart';
import 'payment.dart';

class PackagesScreen extends StatelessWidget {
  final String companyName;

  PackagesScreen({Key? key, required this.companyName}) : super(key: key);

  // Sample data for packages. Ideally, fetch this from your backend API.
  final List<Map<String, dynamic>> packages = [
    {'name': 'Luxury Retreat', 'price': 1500.0, 'duration': '5 Days'},
    {'name': 'Adventure Expedition', 'price': 1000.0, 'duration': '3 Days'},
    {'name': 'Cultural Immersion', 'price': 1200.0, 'duration': '4 Days'},
    {'name': 'Eco Tour', 'price': 900.0, 'duration': '2 Days'},
    {'name': 'Family Package', 'price': 1800.0, 'duration': '6 Days'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$companyName Packages',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white, // White text for the AppBar
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900], // Dark grey AppBar
        elevation: 2, // Subtle shadow for the AppBar
        iconTheme: const IconThemeData(color: Colors.white), // White back button
      ),
      body: Container(
        color: Colors.grey[200], // Light grey background for the entire page
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];
            return Card(
              color: Colors.grey[100], // Light grey for the card background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners for a polished look
              ),
              elevation: 2, // Softer shadow for the cards
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Darker grey text for readability
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.blueGrey, // Muted blue-grey for icons
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          package['duration'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600], // Muted grey for less emphasis
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${package['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent, // Dark blue for prices
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to PaymentScreen with package details
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                packageName: package['name'],
                                packagePrice: package['price'],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[700], // Darker blue-grey button
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // White text on the button
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
