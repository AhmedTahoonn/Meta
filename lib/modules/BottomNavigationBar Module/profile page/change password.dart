import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../styles/icon_broken.dart';


class changePassword extends StatelessWidget {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: double.infinity,
                      //height: 280,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: changePasskey,
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage(
                                      'assets/images/lock2.png'),height: 220,width: 220,),
                                const SizedBox(
                                  height: 10,
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'New Password',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        controller: newPassword,
                                        decoration: InputDecoration(
                                            helperText: "At Least 6 Character",
                                            helperStyle: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic),
                                            contentPadding: EdgeInsets.all(15),
                                            hintText: 'Enter new password',
                                            hintStyle:
                                            const TextStyle(color: Colors.grey, fontSize: 12),
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(IconBroken.Lock),
                                            suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.remove_red_eye_outlined))),
                                        validator: (value) {
                                          if (value!.isEmpty){
                                            return 'This Password can\'t be Empty';
                                          }
                                          if(value.length<6)
                                          {
                                            return 'Must be at least 6 character';
                                          }
                                          else
                                          {
                                            return null;
                                          }
                                        }
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Confirm Password',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        controller: confirmPassword,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(15),
                                            hintText: 'Enter new password',
                                            hintStyle:
                                            const TextStyle(color: Colors.grey, fontSize: 12),
                                            border: const OutlineInputBorder(),
                                            prefixIcon: const Icon(IconBroken.Lock),
                                            suffixIcon: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.remove_red_eye_outlined))),
                                        validator: (value) {
                                          if (value!.isEmpty)
                                          {
                                            return 'This confirm Password can\'t be Empty';
                                          }
                                          if(value!=newPassword.text)
                                          {
                                            return'not the same password';

                                          }
                                          else
                                          {
                                            return null;
                                          }

                                        }
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: OutlinedButton(
                                          onPressed: () {
                                            if (changePasskey.currentState!.validate()) {
                                              HomePageCubit.get(context).changePassword(
                                                  newPassword: confirmPassword.text.trim(),
                                                  context: context);
                                            }
                                          },
                                          child: const Text(
                                            'Change Password',
                                            style: TextStyle(color: Colors.black),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(color: Colors.black),
                                          )),
                                    ),

                                  ],
                                ),
                              ]),
                        ),
                      )),                  const Positioned(
                      top: 0,
                      left: 0,
                      child: Image(
                        image: AssetImage('assets/images/signup_top.png'),
                        width: 130,
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
      listener: (context, state) {
        if(state is SocialChangePasswordSuccessState)
          {

          }

      },
    );
  }

}
