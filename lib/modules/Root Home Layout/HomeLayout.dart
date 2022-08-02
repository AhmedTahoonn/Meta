import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../Bloc/HomePage cubit/HomePage States.dart';

import '../../search.dart';
import '../../styles/icon_broken.dart';
import '../BottomNavigationBar Module/post page/post.dart';

class HomePageLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      builder: (context, state) {

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.4),
          elevation: 0.0,
          title:  Text('${HomePageCubit.get(context).titles[HomePageCubit.get(context).currentIndex]}',style: TextStyle(
              color: Colors.black
          ),),
          actions: [
            IconButton(onPressed: (){
            }, icon: const Icon(IconBroken.Notification,color: Colors.black,)),

            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => search(),));
            }, icon: const Icon(IconBroken.Search,color: Colors.black,)),
          ],
          automaticallyImplyLeading: false,

        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: HomePageCubit.get(context).currentIndex,
          onTap: (value)
          {
            HomePageCubit.get(context).changeBottomNavigationBar(value);
          },
          type: BottomNavigationBarType.fixed,
          items:
          const [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Upload),label: 'Posts'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'chats'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Profile),label: 'Profile'),



          ],
        ),
        body:HomePageCubit.get(context).screens[HomePageCubit.get(context).currentIndex],
      );
      },
      listener: (context,state)
      {
        if(state is moveTOAddNewState)
        {
          Navigator.push(context,MaterialPageRoute(builder: (context) => post_Screen()));
        }
      },
    );
  }
}
