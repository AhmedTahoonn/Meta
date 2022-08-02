
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Bloc/Sign up cubit/Register cuibt.dart';
import '../../Bloc/Sign up cubit/Registerstates.dart';






class signUp_Screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCuibt, RegisterStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SignUP',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SvgPicture.asset('assets/icons/signup.svg'),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),

                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Name';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor:  Color(0xFFF1E6FF),
                                  border: InputBorder.none,
                                  hintText: "Your name",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xFF6F35A5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),

                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Email';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor:  Color(0xFFF1E6FF),
                                  border: InputBorder.none,
                                  hintText: "Your Email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Color(0xFF6F35A5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),

                              child: TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Password';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor:  Color(0xFFF1E6FF),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xFF6F35A5),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.visibility,
                                    color: Color(0xFF6F35A5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCuibt.get(context).UserRegister(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                        name: nameController.text.trim(),
                                      context: context
                                    );
                                  }
                                },
                                child: const Text('SignUp'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF6F35A5)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('I have an account'),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(color: Color(0xFF6F35A5)),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                        thickness: 1,
                                        color: Colors.purple[900])),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    'OR',
                                    style:
                                        TextStyle(color: Colors.purple[900]),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(
                                        thickness: 1,
                                        color: Colors.purple[900])),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: SvgPicture.asset(
                                    'assets/icons/facebook.svg',
                                    height: 25,
                                    width: 25,
                                    color: Colors.purple[900],
                                  )),
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: SvgPicture.asset(
                                      'assets/icons/twitter.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.purple[900])),
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: SvgPicture.asset(
                                      'assets/icons/google-plus.svg',
                                      height: 25,
                                      width: 25,
                                      color: Colors.purple[900])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                  const Positioned(
                      top: 0,
                      left: 0,
                      child: Image(
                        image: AssetImage('assets/images/signup_top.png'),
                        width: 110,
                      )),
                  const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image(
                        image: AssetImage('assets/images/login_bottom.png'),
                        width: 80,
                      )),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
