import 'package:flutter/material.dart';

// Replace with your actual tourism packages data
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

void main() {
  runApp(MaterialApp(
    home: const SearchScreen(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[200], // Light mode background color
    ),
    darkTheme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[900], // Dark mode background color
    ),
    themeMode: ThemeMode.system, // Use 'ThemeMode.dark' for always dark mode
  ));
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Map<String, String>> filteredCompanies;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCompanies = tourismPackages;
  }

  void _filterCompanies(String query) {
    setState(() {
      filteredCompanies = tourismPackages
          .where((company) => company['company']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Removed app bar for a cleaner look
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCompanies,
              decoration: InputDecoration(
                hintText: 'Search for Tourism Companies',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterCompanies('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey[800], // Adjusted for light and dark modes
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: filteredCompanies.length,
              itemBuilder: (context, index) {
                final company = filteredCompanies[index];
                return _buildCompanyCard(company);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, String> company) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            company['image']!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          company['company']!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.cyanAccent, // Adjusted for light and dark modes
          ),
        ),
        subtitle: Text(
          company['description']!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          // Navigate to company details or perform any action
        },
      ),
    );
  }
}
