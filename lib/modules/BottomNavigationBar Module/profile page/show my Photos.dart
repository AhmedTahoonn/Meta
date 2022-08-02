import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mysocialapp/styles/icon_broken.dart';

import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';


class showMyPhotos extends StatelessWidget {
  final String image;
  final String id;
  showMyPhotos({
    required this.image,
    required this.id,
});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0.0,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: const Icon(IconBroken.Arrow___Left_2),color: Colors.black,),
            title: const Text('My Photos',style: TextStyle(
                color: Colors.black
            ),),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0,left: 8),
                  child: Row(
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
                        child: Text('${HomePageCubit.get(context).userModel!.name}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                     IconButton(onPressed: (){
                       HomePageCubit.get(context).deletePhoto(photoId:id,context: context);

                     }, icon:  const Icon(Icons.more_vert,size: 20,)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit:BoxFit.cover ,
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0,left: 12),
                  child: Column(
                    children: [
                      Row(
                        children:
                        [
                          Expanded(
                            child: InkWell(
                              onTap: (){

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children:
                                  [
                                    const Icon(IconBroken.Heart,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 5,),
                                    Text('0',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          ),


                        ],
                      ),

                      Container(
                        width: double.infinity,
                        height: .5,
                        color: Colors.grey[300],
                      ),
                      Row(
                        children:
                        [
                          Expanded(
                            child: Row(
                              children:
                              [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage('${HomePageCubit.get(context).userModel!.profile}'),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(' write a comment',
                                  style: Theme.of(context).textTheme.caption,
                                ),


                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children:
                                [
                                  const Icon(IconBroken.Heart,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 5,),
                                  Text('Like',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),

                          ),

                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },

      listener: (context, state) {
      },
    );
  }
}
