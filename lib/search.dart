import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/show%20friend%20profile.dart';
import 'package:mysocialapp/styles/icon_broken.dart';



import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../models/UserModell/userModel.dart';
import 'modules/BottomNavigationBar Module/chat page/chat deatils.dart';


class search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Social',style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: const Icon(IconBroken.Arrow___Left_2,color: Colors.black,),),
          ),

          body: ConditionalBuilderRec(
            condition: HomePageCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItems(HomePageCubit.get(context).users[index],context),
              separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              itemCount: HomePageCubit.get(context).users.length,
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );


  }
  Widget buildChatItems(UserModel model,context)=> InkWell(
    onTap: (){
      HomePageCubit.get(context).userPhotos(receiverId: model.uId!);
      Navigator.push(context, MaterialPageRoute(builder: (context) => friendProfile(
        model: model,
      ),));

    },
    child: Padding(
      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10),
      child: Column(
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.profile}'),
              ),
              const SizedBox(
                width: 15,
              ),
              Text('${model.name}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),

            ],
          ),

        ],
      ),
    ),
  );
}
