import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../models/UserModell/userModel.dart';
import '../../../test.dart';
import 'chat deatils.dart';


class Chats extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(
        userModel: model,
      ),));
      HomePageCubit.get(context).Recivver=model.uId;

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
