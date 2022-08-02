import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/models/post%20model/model%20post.dart';
import 'package:mysocialapp/styles/icon_broken.dart';


import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../models/UserModell/userModel.dart';
import 'modules/BottomNavigationBar Module/profile page/show my Photos.dart';



class  friendProfile extends StatelessWidget {
  UserModel ?model;
  friendProfile({
    this.model,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit,HomePageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(model!.name!,style: TextStyle(
              color: Colors.black
            ),),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(IconBroken.Arrow___Left_2,color: Colors.black,),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:
                [


                  Container(
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
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(6)
                                    ,topRight:  Radius.circular(6)
                                ),
                                image: DecorationImage(
                                  image:NetworkImage('${model!.cover}'),
                                  fit: BoxFit.cover,

                                ),)
                          ),
                        ),
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('${model!.profile}'),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${model!.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${model!.bio}',
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
                                Text('100',
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
                                Text('${HomePageCubit.get(context).friendsPhotos.length}',
                                  style: TextStyle(
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
                          },
                          child: const Text('Add Photos'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                        onPressed: (){
                        },
                        child: const Icon(Icons.edit,size: 15,),

                      ),
                    ],
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.2,
                    crossAxisSpacing:1.2,


                    childAspectRatio: 1/1.2,
                    children:List.generate(HomePageCubit.get(context).friendsPhotos.length, (index) => buildPhotoItem(HomePageCubit.get(context).friendsPhotos[index],context,index),),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => showMyPhotos(image: model.postImage!,id: HomePageCubit.get(context).photoIdAll[index],)));
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
