import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysocialapp/modules/login%20page/resetpassword/resetpassword.dart';
import '../../Bloc/Login cubit/Login States.dart';
import '../../Bloc/Login cubit/LoginCubit.dart';
import '../sign up page/SignUp_Screen.dart';

class loginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
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
                      key:formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SvgPicture.asset('assets/icons/login.svg'),

                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor:Color(0xFFF1E6FF),
                                  hintText: "Your Email",
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
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                                  border: InputBorder.none,
                                  fillColor:  Color(0xFFF1E6FF),
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
                            height: 8,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:
                              [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => resetpassword(),));
                                  },
                                  child: const Text('Forgot Password?',style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,

                                  ),),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                    {
                                      LoginCubit.get(context).login(email: emailController.text.trim(), password: passwordController.text.trim(),context: context);
                                    }
                                },
                                child: const Text('LogIn'),
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
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('I Don\'t have an account'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => signUp_Screen(),));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Color(0xFF6F35A5)),
                                ),
                              ),
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
      listener: (context, state) {
        if(state is LoginErrorState)
          {
            Fluttertoast.showToast(
                msg: state.error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
        );

          }

      },
    );
  }
}
