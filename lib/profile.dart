import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Text('Go to Profile'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileScreenContent();
  }
}

class ProfileScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: _buildAppBarGradient(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: ProfileBody(),
    );
  }

  Widget _buildAppBarGradient() {
    return Container(
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
    );
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profile_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/profile_placeholder.jpg'),
              ),
              SizedBox(height: 20),
              _buildProfileText('Kevin Heart', FontWeight.bold),
              SizedBox(height: 10),
              _buildProfileText('Software Developer', FontWeight.normal),
              SizedBox(height: 20),
              Divider(
                color: Colors.white,
                thickness: 1,
                height: 20,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(height: 10),
              ProfileInfoRow(
                title1: 'Email',
                value1: 'KevinHeart@gmail.com',
                title2: 'Phone',
                value2: '+123 456 7890',
              ),
              SizedBox(height: 10),
              ProfileInfoRow(
                title1: 'Location',
                value1: 'New York, USA',
                title2: 'Joined',
                value2: 'January 2023',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showEditDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black.withOpacity(0.5),
                  elevation: 10,
                ),
                child: Text(
                  'EDIT PROFILE',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileText(String text, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        color: Colors.black,
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: Colors.white.withOpacity(0.5),
            offset: Offset(0, 3),
          ),
        ],
        fontSize: 24,
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: EditProfileForm(),
          ),
        );
      },
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String title1;
  final String value1;
  final String title2;
  final String value2;

  const ProfileInfoRow({
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ProfileInfoCard(
            title: title1,
            value: value1,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: ProfileInfoCard(
            title: title2,
            value: value2,
          ),
        ),
      ],
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: 'KevinHeart@gmail.com');
  final TextEditingController phoneController = TextEditingController(text: '+123 456 7890');
  final TextEditingController locationController = TextEditingController(text: 'New York, USA');
  final TextEditingController joinedController = TextEditingController(text: 'January 2023');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          _buildTextField('Email', emailController),
          SizedBox(height: 10),
          _buildTextField('Phone', phoneController),
          SizedBox(height: 10),
          _buildTextField('Location', locationController),
          SizedBox(height: 10),
          _buildTextField('Joined', joinedController),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            child: Text(
              'SAVE CHANGES',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
