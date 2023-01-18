// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userRepository = UserRepository();

  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent, Colors.lightGreen],
                  ),
                ),
                child: Form(
                    key: _formKey,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(90))),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person,
                                size: 90,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          const Spacer(),
                          _buildEmail(),
                          _buildPassword(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, right: 32, bottom: 16),
                              child: TextButton(
                                onPressed: () async {
                                  await Navigator.of(context)
                                      .pushNamed('/user-registry');
                                },
                                child: const Text('Doesn`t have an account?',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          _buildButton(),
                          const Spacer(),
                        ]))))));
  }

  Container _buildButton() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Center(
        child: TextButton(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                final email = _emailController.text;
                final password = _passwordController.text;
                bool conditon =
                    await _userRepository.findLogin(email, password);
                if (conditon) {
                  Navigator.of(context).pushNamed('/home');
                } else if (!conditon) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Your email or password is incorrect, please try again!!')));
                }
                // try {
                //   await _userRepository.findLogin(email, password);
                //   await Navigator.of(context).pushNamed('/home');
                //   Navigator.of(context).pop(true);
                // } catch (e) {
                //   Navigator.of(context).pop(false);
                // }
              }
            },
            child: Text(
              'LOGIN'.toUpperCase(),
              style: const TextStyle(
                  color: Colors.lightGreen, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Container _buildEmail() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.white),
          color: Colors.transparent,
          boxShadow: const [
            BoxShadow(color: Colors.transparent, blurRadius: 5)
          ]),
      child: TextFormField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.white)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter with a E-mail';
            } else if (value.length < 5 || value.length > 30) {
              return 'E-mail must be between 5 and 30 characters';
            } else if (EmailValidator.validate(value.toString()) == false) {
              return 'Please enter a valid E-mail';
            }
            return null;
          }),
    );
  }

  Container _buildPassword() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.white),
          color: Colors.transparent,
          boxShadow: const [
            BoxShadow(color: Colors.transparent, blurRadius: 5)
          ]),
      child: TextFormField(
        cursorColor: Colors.white,
        obscureText: passwordVisible,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.visiblePassword,
        textAlignVertical: TextAlignVertical.center,
        controller: _passwordController,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: const Icon(
              Icons.vpn_key,
              color: Colors.white,
            ),
            hintText: 'Password',
            hintStyle: const TextStyle(color: Colors.white),
            suffixIcon: IconButton(
                onPressed: togglePasswordVisibility,
                icon: passwordVisible
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ))),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter with a Password';
          }
          if (value.length < 5 || value.length > 30) {
            return 'Password must be between 5 and 30 characters';
          }
          return null;
        },
      ),
    );
  }

  void togglePasswordVisibility() =>
      setState(() => passwordVisible = !passwordVisible);
}
