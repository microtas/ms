import 'package:flutter/material.dart';
import 'package:ms_maintain/API/HttpRequest.dart';
import 'package:ms_maintain/API/classes.dart';
import 'package:ms_maintain/API/paresXML.dart';
import 'package:ms_maintain/API/user.dart';
import 'package:ms_maintain/Client/HomePage.dart';
import 'package:ms_maintain/Technicien/homepage_technicien.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _matriculeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
            ),
          ),
          
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logoms.png',
                      height: 300,
                      width: 400,
                    ),
                    const SizedBox(height: 0),

                    // Login Card
                    SizedBox(
                      width: 400,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 20,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Text(
                                  'Connexion',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 20),
                      
                                // Email Field
                                _buildTextFormField(
                                  label: 'Identifant...',
                                  icon: Icons.perm_identity_sharp,
                                  controller: _matriculeController,
                                  validator: _validateEmail,
                                ),
                                const SizedBox(height: 20),
                      
                                // Password Field
                                _buildTextFormField(
                                  label: 'Mot de Passe',
                                  icon: Icons.lock,
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  validator: _validatePassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                      
                                // Error Message
                                AnimatedOpacity(
                                  opacity: _errorMessage.isNotEmpty ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    _errorMessage,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 20),
                      
                                // Submit Button
                               SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:_submit,

                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.blue[900],
                            elevation: 4,
                          ),
                          child: const Text(
                            'Se Connecter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                       SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:(){
                                  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
                          },

                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.blue[900],
                            elevation: 4,
                          ),
                          child: const Text(
                            'CLIENT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                             
                              ],
                            ),
                          ),
                        ),
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

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? hint,
    bool obscureText = false,
    IconData? icon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: Colors.black54) : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }

void _submit() async {
  if (_formKey.currentState?.validate() ?? false) {
    setState(() {
      _errorMessage = '';
      _isLoading = true; // Active le chargement
    });

    // Vérification si la matricule est alphabétique
bool isMatriculeAlphabetic = RegExp(r'^[a-zA-Z]+$').hasMatch(_matriculeController.text.trim());
try {
  if (isMatriculeAlphabetic) {
    final user = await THttpHelper.post<User>(
      'GetUser',
      {
        'Login': _matriculeController.text,
        'Pass': _passwordController.text,
      },
      (responseBody) {
        return parseUser(responseBody);
      },
    );

    if (user.isNotEmpty) {
            print('le technicien $user');

          final loggedInUser = user.first;
          CurrentUser.setLoggedInUser(loggedInUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageTechnicien()),
      );
    } else {
      setState(() {
        _errorMessage = 'Identifiant ou mot de passe incorrect.';
      });
    }
  } else {
    final client = await THttpHelper.post<Client>(
      'GetCLient',
      {
        'Login': _matriculeController.text,
        'Pass': _passwordController.text,
      },
      (responseBody) {
        return parseClient(responseBody);
      },
    );

    if (client.isNotEmpty) {
          final loggedInClient = client.first;
          CurrentUser.setLoggedInClient(loggedInClient); 

      print(client);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Identifiant ou mot de passe incorrect.';
      });
    }
  }
} catch (e) {
  setState(() {
    _errorMessage = 'Erreur: $e';
  });
  print('Erreur lors de la requête: $e');
}

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Veuillez corriger les erreurs')),
    );
  }
}

  
  
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est obligatoire';
    }
    
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est obligatoire';
    }
  
  }
}