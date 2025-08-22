import 'package:flutter/material.dart';

import 'package:playem/utils/service/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  bool _isLoading = false;
  bool obscureText = true;

  Future<void> _sibmit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _isLoading = true);
    String? exit;

    if (_isLogin) {
      exit = await AuthService.signIn(email, password);
    } else {
      exit = await AuthService.signUp(email, password);
    }
    setState(() => _isLoading = false);

    if (exit != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME in',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                Text(
                  'Playem!!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,

                  // Checking the correctness Email
                  validator: (value) {
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (value == null || value.isEmpty) {
                      return 'Please, email';
                    }

                    if (!emailRegex.hasMatch(value)) {
                      return 'Incorrect email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: obscureText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: obscureText
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open),
                    ),
                    labelText: 'password',
                  ),

                  // Checking the correctness Password
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, pass';
                    }
                    if (value.length < 8) {
                      return 'The password must contain at least 8 charecters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _sibmit();

                            // The form is valid, you can send the data
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data is being processed...'),
                              ),
                            );
                          }
                        },
                        child: Text(_isLogin ? 'Sign in' : 'Sign Up'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _isLogin = !_isLogin);
                        },
                        child: Text(
                          _isLogin
                              ? "No account? Sing up"
                              : "Do you already have an account? Sing in",
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
