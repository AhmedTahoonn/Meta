import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/styles/icon_broken.dart';

import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';






class addPhoto_Screen extends StatelessWidget {
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
              icon: Icon(IconBroken.Arrow___Left_2,color: Colors.black,),
            ),
            title: const Text('Add Photo',
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            actions:
            [
              TextButton(onPressed: (){
                final now = DateTime.now();
                  HomePageCubit.get(context).uploadNewPhotoImage(dateTime: now.toString(), text: textController.text,context: context);


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
                if(state is SocialUploadPhotoLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialUploadPhotoLoadingState)
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
                    maxLines: null,
                    controller: textController,
                    style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                    ),

                    decoration: InputDecoration(
                      hintText: 'what is on your mind',
                      border: InputBorder.none,
                    ),

                  ),
                ),
                if(HomePageCubit.get(context).addPhoto!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 380,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6)
                                ,topRight:  Radius.circular(6)
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(HomePageCubit.get(context).addPhoto!)

                            ),)
                      ),
                      IconButton(
                        onPressed: (){
                          HomePageCubit.get(context).removePickImage();
                        }, icon: CircleAvatar(
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
                          HomePageCubit.get(context).pickAddPhoto();
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
                        child: Text('# tags'),

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
