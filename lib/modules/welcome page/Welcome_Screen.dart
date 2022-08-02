import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../login page/Login_Screen.dart';
import '../sign up page/SignUp_Screen.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children:
            [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                      child: Text('Welcome',style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[800]
                      ),),
                    ),
                    SvgPicture.asset('assets/icons/chat.svg'),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen(),));
                        }, child:const Text('LogIn'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF6F35A5)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                        ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: SizedBox(
                       width: double.infinity,

                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => signUp_Screen(),));

                        }, child:const Text('SignUp',style: TextStyle(
                          color: Colors.black
                        ),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFFF1E6FF)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const Positioned(
                  top: 0,
                  left: 0,
                  child: Image(image: AssetImage('assets/images/main_top.png'),width: 110,)),
              const Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image(image: AssetImage('assets/images/main_bottom.png'),width: 70,)),

            ],
          ),
        ),
      ),
    );
  }
}

