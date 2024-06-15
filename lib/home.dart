import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'slide_transition.dart';
import 'payment.dart';
import 'order_history.dart';
import 'search.dart';
import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2; // Home is the middle button
  PageController _pageController = PageController(initialPage: 2);
  late AnimationController _animationController;

  final List<Map<String, String>> tourismPackages = [
    {
      'company': 'Jetwing Travels',
      'image': 'assets/images/Jetwing.png',
      'description': 'Experience luxury and sustainability in every journey.'
    },
    {
      'company': 'Walkers Tours',
      'image': 'assets/images/walkers.jpg',
      'description': 'Leading tour operator with personalized travel solutions.'
    },
    {
      'company': 'Aitken Spence Travels',
      'image': 'assets/images/aitken.jpg',
      'description': 'Award-winning travel services and diverse tour packages.'
    },
    {
      'company': 'Cinnamon Holidays',
      'image': 'assets/images/cinnamon.jpeg',
      'description': 'Innovative holiday experiences across Sri Lanka.'
    },
    {
      'company': 'Blue Lanka Tours',
      'image': 'assets/images/bluelanka.jpeg',
      'description': 'Personalized and luxurious travel experiences.'
    },
    {
      'company': 'Red Dot Tours',
      'image': 'assets/images/reddot.jpg',
      'description': 'Tailor-made travel solutions and unique experiences.'
    },
    {
      'company': 'Sri Lanka Tailor-Made',
      'image': 'assets/images/sri-lanka-tailor-made.png',
      'description': 'Bespoke tours with a focus on local culture and nature.'
    },
    {
      'company': 'Helanka Vacations',
      'image': 'assets/images/helanka.png',
      'description': 'Comprehensive travel solutions and holiday packages.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
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
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
              SlideTransitionPage(page: SettingsScreen(), direction: AxisDirection.left),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                SlideTransitionPage(page: ProfileScreen(), direction: AxisDirection.right),
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
            PaymentScreen(),
            OrderHistoryScreen(),
            // HomeScreen content
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: tourismPackages.length,
              itemBuilder: (context, index) {
                final package = tourismPackages[index];
                return GestureDetector(
                  onTap: () {
                    // Handle package tap
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueGrey.withOpacity(0.4),
                            Colors.black.withOpacity(0.7)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              package['image']!,
                              height: 200,
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
                                  package['company']!,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  package['description']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Handle view more details
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.cyanAccent,
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'VIEW DETAILS',
                                    style: TextStyle(fontSize: 16),
                                  ),
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
            SearchScreen(),
            NotificationsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: kBottomNavigationBarHeight * 1.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarIcon(Icons.payment, 0, 'Payment'),
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
        size: isSelected ? 36 : 28,
        color: isSelected ? Colors.white : Colors.grey[600],
      ),
      onPressed: () => _onItemTapped(index),
      splashColor: Colors.transparent,
    );
  }
}

void main() => runApp(MaterialApp(
  home: HomeScreen(),
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
));
