
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/styles/icon_broken.dart';

import '../../../Bloc/Login cubit/Login States.dart';
import '../../../Bloc/Login cubit/LoginCubit.dart';


class resetpassword extends StatelessWidget {
  var email = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 12),
                    child: Form(
                      key:formKey ,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage(
                                    'assets/images/changePassword1.jpg')),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Forgot\nPassword?',
                                  style: TextStyle(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Don\'t worry! please enter the email address associated with your accoun.t ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                TextFormField(
                                    controller: email,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(15),
                                        hintText: 'Enter Your Email',
                                        hintStyle:
                                        const TextStyle(color: Colors.grey, fontSize: 12),
                                        border: const OutlineInputBorder(),

                                        prefixIcon: const Icon(IconBroken.Lock),
                                        suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.remove_red_eye_outlined))),
                                    validator: (value) {
                                      if (value!.isEmpty){
                                        return 'This Email can\'t be Empty';
                                      }
                                      else
                                      {
                                        return null;
                                      }
                                    }
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: ElevatedButton(
                                    onPressed: () {
                                     Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(const Color(0xFF6F35A5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 130,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate())
                                      {
                                        LoginCubit.get(context).resetPassword(emailAddress: email.text.trim(),context: context);
                                      }
                                    },
                                    child: const Text('Send'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(const Color(0xFF6F35A5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                      top: 0,
                      left: 0,
                      child: Image(
                        image: AssetImage('assets/images/main_top.png'),
                        width: 110,
                      )),
                  const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image(
                        image: AssetImage('assets/images/login_bottom.png'),
                        width: 120,
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
