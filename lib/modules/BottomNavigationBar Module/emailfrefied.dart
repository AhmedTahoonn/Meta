
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../Bloc/HomePage cubit/HomePage States.dart';
import '../Root Home Layout/HomeLayout.dart';


class emailf extends StatelessWidget {
  const emailf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Home',style: TextStyle(
                color: Colors.black
            ),),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: ConditionalBuilderRec(
            condition: HomePageCubit.get(context).userModel!=null,
            builder: (context)=> Column(
              children:
              [
                if(!HomePageCubit.get(context).userModel!.isEmailVerified!)
                  Container(
                    color: Colors.amber,
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
                        const SizedBox(
                          width: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('Please verfiy your email'),
                        ),
                        const Spacer(),
                        MaterialButton(onPressed: (){
                          FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  HomePageLayout(),), (route) => false);
                          }).catchError((error){
                          });
                        },child: const Text('Send',style: TextStyle(
                            color: Colors.blue
                        ),),),
                      ],
                    ),
                  )
              ],
            ),
            fallback: (context)=>const Center(child: LinearProgressIndicator()),
          ),
        );
      },
      listener: (context, state) {
      },
    );
  }
}
