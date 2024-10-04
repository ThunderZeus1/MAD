import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile.dart';
import 'settings.dart';
import 'slide_transition.dart';
import 'order_history.dart';
import 'search.dart';
import 'notifications.dart';
import 'packages.dart';
import 'package:permission_handler/permission_handler.dart'; // For runtime permissions

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2; // Home is the middle button
  final PageController _pageController = PageController(initialPage: 2);

  final List<Map<String, String>> tourismCompanies = [
    {'company': 'Jetwing Travels', 'image': 'assets/images/Jetwing.png'},
    {'company': 'Walkers Tours', 'image': 'assets/images/walkers.jpg'},
    {'company': 'Aitken Spence Travels', 'image': 'assets/images/aitken.jpg'},
    {'company': 'Cinnamon Holidays', 'image': 'assets/images/cinnamon.jpeg'},
    {'company': 'Blue Lanka Tours', 'image': 'assets/images/bluelanka.jpeg'},
    {'company': 'Red Dot Tours', 'image': 'assets/images/reddot.jpg'},
    {'company': 'Sri Lanka Tailor-Made', 'image': 'assets/images/sri-lanka-tailor-made.png'},
    {'company': 'Helanka Vacations', 'image': 'assets/images/helanka.png'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'Tourism Companies',
          style: TextStyle(
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
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              SlideTransitionPage(page: const SettingsScreen(), direction: AxisDirection.left),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                SlideTransitionPage(page: const ProfileScreen(), direction: AxisDirection.right),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            SupportScreen(), // Index 0: Support Screen
            OrderHistoryScreen(), // Index 1
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: tourismCompanies.length,
              itemBuilder: (context, index) {
                final company = tourismCompanies[index];
                return GestureDetector(
                  onTap: () {
                    // Optional: Handle card tap if needed
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              company['image']!,
                              height: height * 0.25,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  company['company']!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: OverflowBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PackagesScreen(
                                          companyName: company['company']!,
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text('SEE PACKAGES', style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SearchScreen(), // Index 3
            const NotificationsScreen(), // Index 4
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: kBottomNavigationBarHeight * 1.5,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: 10,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarIcon(Icons.support_agent, 0, 'Support'),
            buildNavBarIcon(Icons.history, 1, 'History'),
            buildNavBarIcon(Icons.home, 2, 'Home'),
            buildNavBarIcon(Icons.search, 3, 'Search'),
            buildNavBarIcon(Icons.notifications, 4, 'Notifications'),
          ],
        ),
      ),
    );
  }

  // Helper method to build each icon in the bottom navigation bar
  Widget buildNavBarIcon(IconData icon, int index, String label) {
    bool isSelected = _selectedIndex == index;

    return IconButton(
      icon: Icon(
        icon,
        size: isSelected ? 32 : 28,
        color: isSelected ? Colors.blueAccent : Colors.grey[400],
      ),
      onPressed: () => _onItemTapped(index),
      splashColor: Colors.transparent,
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  // Function to check and request permission, then make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    // Request permission to make a phone call
    PermissionStatus permissionStatus = await Permission.phone.request();

    if (permissionStatus.isGranted) {
      // If permission is granted, make the call
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      // Check if the phone call can be initiated
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        // Handle failure to launch
        throw 'Could not launch $launchUri';
      }
    } else {
      // Handle permission denied scenario
      throw 'Phone call permission denied';
    }
  }

  // Function to launch email client
  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch email client for $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              'For any inquiries or support, please reach out to us through the following options:',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text('+94 71 234 5678', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: const Text('Call us for immediate assistance', style: TextStyle(color: Colors.black54)),
                onTap: () => _makePhoneCall('0712345678'), // Use the correct local number format
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blueAccent),
                title: const Text('support@example.com', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: const Text('Send us an email for any inquiries', style: TextStyle(color: Colors.black54)),
                onTap: () => _sendEmail('support@example.com'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.support, color: Colors.orangeAccent),
                title: const Text('Live Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: const Text('Chat with us directly', style: TextStyle(color: Colors.black54)),
                onTap: () {
                  // You can navigate to a chat or live support screen here
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
