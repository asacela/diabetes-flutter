import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';

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
  bool _isLoading = false;

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {

    Uint8List im = await pickImage(ImageSource.gallery);
    setState( () {
      _image = im;
    });
  }

  void signUpUser () async {

    String res;
    setState(() {
      _isLoading = true;
    });

    if (_image != null){
      res = await AuthMethods().signUpUser(
        email: _emailController.text, 
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!,
      );
    }
    else{
      res = "Complete sign up and add a profile pic!";
    }

    if (res != "success"){

      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute( 
        builder: (context) => 
          const ResponsiveLayout(
          mobileScreenLayout: mobileScreenLayout(),
          webScreenLayout: webScreenLayout(),
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              // svg image
              const SizedBox(height: 52,),

              Stack(
                children: [
              
                  _image != null ? CircleAvatar( 
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  ) :
                  const CircleAvatar(
                    radius: 64 ,
                    backgroundImage: NetworkImage('https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg',),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage, 
                    icon: const Icon(Icons.add_a_photo,),),)
                ],
              ),

              const SizedBox(height: 24,),
              SvgPicture.asset('assets/ic_instagram.svg', color: primaryColor, height: 64, ),


              const SizedBox(height: 64,),

              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(height: 24),

              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading ? 
                  const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                  : const Text("Sign up"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  )
                ),
              ),

              const SizedBox(height: 12,),

              Flexible(child: Container(), flex: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Already have an account?"),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  const SizedBox(width: 10,),

                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text("Log in.", style: TextStyle(fontWeight: FontWeight.bold,),),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        )
      ),
    );
  }
}