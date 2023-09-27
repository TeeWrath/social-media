import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/resources/auth.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/utils.dart';
import 'package:insta/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),

            // logo
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              height: 64,
            ),

            const SizedBox(
              height: 24,
            ),

            Stack(
              children: [
                _image != null 
                ? CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                ):
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%3Fk%3D%2522default%2Bprofile%2Bpicture%2522&psig=AOvVaw0MhFrpNnwEDQ-poIzwxWDV&ust=1695939790013000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCMCp5v3py4EDFQAAAAAdAAAAABAE'),
                ),
                Positioned(
                  bottom: -10,
                  right: 8,
                  child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo)),
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            // username
            TextFieldInput(
              textEditingController: _usernameController,
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
            ),

            const SizedBox(
              height: 24,
            ),

            // textbox email
            TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
            ),

            const SizedBox(
              height: 24,
            ),

            // bio
            TextFieldInput(
              textEditingController: _bioController,
              hintText: 'Enter your bio',
              textInputType: TextInputType.multiline,
            ),

            const SizedBox(
              height: 24,
            ),

            // textbox psswd
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
              height: 24,
            ),

            // button
            InkWell(
              onTap: () async {
                String res = await AuthMethods().signupUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                    bio: _bioController.text);
                print(res);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
                child: const Text('Signup'),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Flexible(
              flex: 1,
              child: Container(),
            ),

            // transition to signup page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text('Already have an account?'),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
