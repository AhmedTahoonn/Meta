import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/styles/icon_broken.dart';

import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';





class post_Screen extends StatelessWidget {
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0.0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2,color: Colors.black,),
            ),
            title: const Text('Create Post',
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            actions:
            [
              TextButton(onPressed: (){
                final now = DateTime.now();

                if(HomePageCubit.get(context).postImage == null)
                {
                  HomePageCubit.get(context).createPost(dateTime: now.toString(), text: textController.text,context: context);
                }
                else{
                  HomePageCubit.get(context).uploadNewPostImage(dateTime: now.toString(), text: textController.text,context: context);

                }
              }, child: const Text('POST',style: TextStyle(
                  color: Colors.blue
              ),),)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)

                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${HomePageCubit.get(context).userModel!.profile}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Row(
                            children:
                            [
                              Text('${HomePageCubit.get(context).userModel!.name}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 50,
                    controller: textController,
                    style: const TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                    ),

                    decoration: const InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),

                  ),
                ),
                if(HomePageCubit.get(context).postImage!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6)
                                ,topRight:  Radius.circular(6)
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(HomePageCubit.get(context).postImage!)

                            ),)
                      ),
                      IconButton(
                        onPressed: (){
                          HomePageCubit.get(context).removePostImage();
                        }, icon: const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.close),
                      ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          HomePageCubit.get(context).pickPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children:
                          const [
                            Icon(Icons.image),
                            SizedBox(width: 5,),
                            Text('add photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: const Text('# tags'),

                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
