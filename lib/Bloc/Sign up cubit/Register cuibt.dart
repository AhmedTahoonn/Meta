import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/UserModell/userModel.dart';
import '../../modules/login page/Login_Screen.dart';
import 'Registerstates.dart';

class RegisterCuibt extends Cubit<RegisterStates> {
  RegisterCuibt() : super(SignUpInitialState());

  static RegisterCuibt get(context) => BlocProvider.of(context);

  void UserRegister({
    required String name,
    required String email,
    required String password,
    required dynamic context,

  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password,)
        .then((value) {
      CreateUser(name: name,email: email,password: password,uId: value.user!.uid);
      emit(RegisterSuccessState());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => loginScreen(),), (route) => true);
      Fluttertoast.showToast(
          msg: 'Add Account Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    })
        .catchError((error) {
          print(error.toString());
          emit(RegisterErrorState());
    });
  }
  void CreateUser({
    required String name,
    required String email,
    required String password,
    required String uId,
}){
   UserModel userModel=UserModel(name: name,
       email: email,
       phone: '01281300656',
       uId: uId,
     isEmailVerified: false,
     bio:'write your bio ....',
     profile: 'https://img.freepik.com/free-photo/horizontal-shot-happy-afro-american-woman-with-toothy-smile_273609-25672.jpg?size=626&ext=jpg',
     cover: 'https://img.freepik.com/free-photo/horizontal-shot-happy-afro-american-woman-with-toothy-smile_273609-25672.jpg?size=626&ext=jpg',
   );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CreateUserErrorState());
    });
}
}
