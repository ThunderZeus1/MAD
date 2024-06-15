import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  // Controllers for the text fields
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  // Animation controller
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isRegistered = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  // Function to register a user
  Future<void> registerUser(
      String userName, String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/Register');
    var response = await http.post(url, body: {
      'name': userName,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      print('User registered');
      setState(() {
        _isRegistered = true;
        _fadeController.forward();
      });
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration unsuccessful'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with a soft gradient overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/registration.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _userName,
                    decoration: InputDecoration(
                      hintText: 'User Name',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Handle registration
                      String userName = _userName.text;
                      String email = _email.text;
                      String password = _password.text;
                      String confirmPassword = _confirmPassword.text;

                      if (confirmPassword != password) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                          ),
                        );
                      } else {
                        registerUser(userName, email, password);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black.withOpacity(0.5),
                      elevation: 10,
                    ),
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to the previous screen
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isRegistered)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                        size: 48,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Registration Successful!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
