import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/styles/icon_broken.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../Constant/constant.dart';
import '../../../models/post model/model post.dart';

class page1 extends StatelessWidget {
  List recents = [
    {
      "image":
          "https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1645485090~exp=1645485690~hmac=a68a718e2d53686fc488a986b30f7143acf80b6e6972d78269ed67a4b18361b6&w=740",
      "name": "Double Villa",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1598928506311-c55ded91a20c?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
      "name": "Convertible Studio",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1576941089067-2de3c901e126?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
      "name": "Double Villa",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<HomePageCubit, HomePageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilderRec(
                condition: HomePageCubit.get(context).posts.isNotEmpty &&
                    HomePageCubit.get(context).userModel != null,
                builder: (context) => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          topImage(),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            itemBuilder: (context, index) => buildPostItem(
                                context,
                                HomePageCubit.get(context).posts[index],
                                index),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: HomePageCubit.get(context).posts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                fallback: (context) => ListView.separated(
                      itemBuilder: (context, index) => SizedBox(
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.black.withOpacity(.8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                shimmer(
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: shimmer(
                                        height: 1,
                                        width: 120,
                                      )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: shimmer(
                                        height: 1,
                                        width: 170,
                                      )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: shimmer(
                                        height: 1,
                                        width: 200,
                                      )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: shimmer(
                                        height: 1,
                                        width: 230,
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      itemCount: 5,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      physics: const BouncingScrollPhysics(),
                    )),
          );
        },
      );
    });
  }

  Widget buildPostItem(context, PostModel model, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.profile}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          '${convertDateFromString(model.date!)}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {
                      HomePageCubit.get(context).deletePost(
                          postId: HomePageCubit.get(context).postIdAll[index]);
                    },
                    icon: const Icon(Icons.more_horiz),
                    iconSize: 17,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                child: Container(
                  width: double.infinity,
                  height: .5,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: const TextStyle(
                    height: 1.4, fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
              /*Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children:
                [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,

                      child: MaterialButton(onPressed: (){}, child: Text('# software',
                        style: TextStyle(

                            color: Colors.blue
                        ),
                      ),
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,

                      child: MaterialButton(onPressed: (){}, child: Text('# software',
                        style: TextStyle(

                            color: Colors.blue
                        ),
                      ),
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,

                      child: MaterialButton(onPressed: (){}, child: Text('# software',
                        style: TextStyle(

                            color: Colors.blue
                        ),
                      ),
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,

                      child: MaterialButton(onPressed: (){}, child: Text('# software',
                        style: TextStyle(

                            color: Colors.blue
                        ),
                      ),
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 6),
                    child: Container(
                      height: 25,

                      child: MaterialButton(onPressed: (){}, child: Text('# software',
                        style: TextStyle(

                            color: Colors.blue
                        ),
                      ),
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),*/
              if (model.postImage != '')
                Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    )),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${HomePageCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Star,
                              color: Colors.red,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: .5,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              '${HomePageCubit.get(context).userModel!.profile}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          ' write a comment',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget topImage() => Card(

          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
        children:
        const [
          Image(
            image: NetworkImage(
                "https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1645485090~exp=1645485690~hmac=a68a718e2d53686fc488a986b30f7143acf80b6e6972d78269ed67a4b18361b6&w=740"),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,

          ),

          Padding(
            padding: EdgeInsets.only(bottom: 8.0,left: 8),
            child: Text('Communicate with other',style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),),
          )
        ],
      ));
}
