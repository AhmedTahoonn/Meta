import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/sharedPrefences/cachHelper.dart';
import 'Bloc/HomePage cubit/HomePage Cubit.dart';
import 'Bloc/HomePage cubit/bloc_observe.dart';
import 'Bloc/Login cubit/LoginCubit.dart';
import 'Bloc/Sign up cubit/Register cuibt.dart';
import 'Constant/constant.dart';
import 'modules/BottomNavigationBar Module/Home Page/page1.dart';
import 'modules/Root Home Layout/HomeLayout.dart';
import 'modules/welcome page/Welcome_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  uId=CacheHelper.getData(key: 'uId');
  print(uId);
  if(uId==null)
    {
      widget=welcomeScreen();

    }
  else{
    widget=HomePageLayout();

  }
  Bloc.observer = MyBlocObserver();
  runApp( MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
  Widget ?widget;
  MyApp({
    required this.widget,
});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCuibt(),
        ),
        BlocProvider(
          create: (context) => HomePageCubit()..getPosts()..getUserData()..myPhoto()
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: widget,
      ),
    );
  }
}
