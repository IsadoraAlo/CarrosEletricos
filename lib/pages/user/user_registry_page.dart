// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../repository/user_repository.dart';

class UserRegistry extends StatefulWidget {
  const UserRegistry({super.key});

  @override
  State<StatefulWidget> createState() => _UserRegistryPageState();
}

class _UserRegistryPageState extends State<UserRegistry> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
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
                          _buildName(),
                          _buildUsername(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, right: 32, bottom: 16),
                              child: TextButton(
                                onPressed: () async {
                                  await Navigator.of(context)
                                      .pushNamed('/login');
                                },
                                child: const Text('Already have an account?',
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
                final name = _nameController.text;
                final password = _passwordController.text;
                final username = _usernameController.text;
                final email = _emailController.text;
                final user = User(
                    username: username,
                    name: name,
                    email: email,
                    password: password);
                await _userRepository.registerUser(user);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('User registered successfully!'),
                ));
                await Navigator.of(context).pushNamed('/login');
              }
            },
            child: Text(
              'Create Account'.toUpperCase(),
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
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

  Container _buildName() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height * 0.08,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
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
          controller: _nameController,
          keyboardType: TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Name',
              hintStyle: TextStyle(color: Colors.white)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter with a Name';
            } else if (value.length < 5 || value.length > 30) {
              return 'Name must be between 5 and 30 characters';
            }
            return null;
          }),
    );
  }

  Container _buildUsername() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height * 0.08,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
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
          controller: _usernameController,
          keyboardType: TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.text_fields,
                color: Colors.white,
              ),
              hintText: 'Username',
              hintStyle: TextStyle(color: Colors.white)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter with a Username';
            } else if (value.length < 5 || value.length > 30) {
              return 'Username must be between 5 and 30 characters';
            }
            return null;
          }),
    );
  }

  void togglePasswordVisibility() =>
      setState(() => passwordVisible = !passwordVisible);
}
