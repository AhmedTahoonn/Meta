import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysocialapp/modules/login%20page/Login_Screen.dart';
import 'package:mysocialapp/sharedPrefences/cachHelper.dart';

import '../../modules/Root Home Layout/HomeLayout.dart';
import 'Login States.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({
    required String email,
    required String password,
    required dynamic context
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: 'uId',value: value.user!.uid).then((value) => {
      Fluttertoast.showToast(
      msg: 'Login Successfully',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
      )
      }).catchError((error){});

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePageLayout(),), (route) => false);

      emit(LoginSuccessState(value.user!.uid));
    })
        .catchError((error) {
          emit(LoginErrorState(error.toString()));

    });
  }
  void resetPassword({
  required String emailAddress,
    required dynamic context,
})
  {
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress).then((value) {
    Fluttertoast.showToast(
        msg: 'Check Your Email',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    emit(RestPasswordSuccessState());
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => loginScreen(),), (route) => true);

    }).catchError((error){
      emit(RestPasswordErrorState());

    });
  }
}
