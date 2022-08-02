import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/models/post%20model/model%20post.dart';


import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../models/UserModell/userModel.dart';

import 'add photo.dart';

import 'show my Photos.dart';
import 'editProfiel.dart';



class  page4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        UserModel model=HomePageCubit.get(context).userModel!;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:
                [


                  SizedBox(
                    height: 215,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:
                      [
                        Align(
                          alignment: AlignmentDirectional.topCenter,

                          child: Container(
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(6)
                                    ,topRight:  Radius.circular(6)
                                ),
                                image: DecorationImage(
                                  image:NetworkImage('${model.cover}'),
                                  fit: BoxFit.cover,

                                ),)
                          ),
                        ),
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('${model.profile}'),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${model.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${model.bio}',
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Column(
                              children:
                              [
                                const Text('100',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),


                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Column(
                              children:
                              [
                                 Text('${HomePageCubit.get(context).myPhotos.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),


                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Column(
                              children:
                              [
                                const Text('10k',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),


                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Column(
                              children:
                              [
                                const Text('23',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Following',
                                  style: Theme.of(context).textTheme.caption,
                                ),


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Row(
                    children:
                    [
                      Expanded(
                        child:OutlinedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => addPhoto_Screen(),)) ;
                            },
                          child: const Text('Add Photos'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => editProfileScreen(),));
                        },
                        child: const Icon(Icons.edit,size: 15,),

                      ),
                    ],
                  ),
                  SizedBox(

                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 1.2,
                      crossAxisSpacing:1.2,


                      childAspectRatio: 1/1.2,
                      children:List.generate(HomePageCubit.get(context).myPhotos.length, (index) => buildPhotoItem(HomePageCubit.get(context).myPhotos[index],context,index),),
                    ),

                  ),





                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget buildPhotoItem(PostModel model,context,index)=>InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => showMyPhotos(image: model.postImage!,id: HomePageCubit.get(context).myPhotoIdAll[index],)));
    },
    child: Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(model.postImage!)
        )
      ),
    ),
  );
}
