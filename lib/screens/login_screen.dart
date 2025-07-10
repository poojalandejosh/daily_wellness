import 'package:daily_wellness/core/constants/constant.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final bool showImage;
  const Login({super.key, this.showImage = true});

  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = isLandscape
                  ? size.width * 0.6
                  : size.width * 0.9;

              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showImage)
                      Image.asset(
                        'assets/images/health.png',
                        height: 70,
                        width: 70,
                        fit: BoxFit.contain,
                      ),
                    if (widget.showImage) const SizedBox(height: 24),
                    const Text(
                      "DailyWellness",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: contentWidth,
                      child: TextFormField(
                        controller: emailCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: email,
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return emailRequired;
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                            return emailValidation;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: contentWidth,
                      child: TextFormField(
                        controller: passwordCtrl,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: password,
                          labelStyle: const TextStyle(color: Colors.white70),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white60,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? passwordRequired
                            : null,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: contentWidth,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            231,
                            97,
                            189,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 30,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          login,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
