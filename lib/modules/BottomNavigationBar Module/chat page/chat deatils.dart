import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/models/UserModell/userModel.dart';
import 'package:mysocialapp/styles/icon_broken.dart';

import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../models/message model/model message.dart';
import '../../../test.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  var messageController = TextEditingController();

  ChatDetailsScreen({
    this.userModel,
  });

  var ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomePageCubit.get(context).getMessage(receiverId: userModel!.uId!);
        return BlocConsumer<HomePageCubit, HomePageStates>(
          listener: (context, state) {
            if (state is SocialGetMessageSuccessState) {
              messageController.clear();
            }
            if(state is SocialPickedChatPhotoSuccessState)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SendChatImage(),));
              }
          },
          builder: (context, state) {
            return Scaffold(
                key: ScaffoldKey,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(IconBroken.Arrow___Left_2,
                        color: Colors.black),
                  ),
                  backgroundColor: Colors.white.withOpacity(0.4),
                  elevation: 0.0,
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${userModel!.profile}'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${userModel!.name}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                body: ConditionalBuilderRec(
                  condition: true,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                                HomePageCubit.get(context).messages[index];
                            if (HomePageCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return buildMyMessage(message);
                            }
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: HomePageCubit.get(context).messages.length,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(IconBroken.Upload),
                            onPressed: () {
                              ScaffoldKey.currentState!.showBottomSheet((context) => SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                  [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:
                                        [
                                          Text('Camera'),
                                          IconButton(icon: const Icon
                                            (IconBroken.Camera),onPressed: (){
                                            HomePageCubit.get(context).pickChatImageCamera();
                                          },)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children:
                                        [
                                          Text('Gallery'),
                                          IconButton(icon: const Icon
                                            (IconBroken.Camera),onPressed: (){
                                            HomePageCubit.get(context).pickChatImageGallery();

                                          },)
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ));
                            },
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 40,
                            child: MaterialButton(
                              onPressed: () {
                                HomePageCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                Icons.send,
                                size: 18.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ));
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            height: 200,
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10)),
            ),
            child:  Column(
                children:[
                  if(model.image!=null)
                    SizedBox(
                        height: 200,width: 200,
                        child: Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/mysocialapp-e8928.appspot.com/o/ChatImages%2Fimage_picker4253657698144777979.png?alt=media&token=c73ff167-1ced-42a0-8e4f-2f07df392146'))),
                  if(model.text!=null)
                    Text(
                      '${model.text}',
                      style: const TextStyle(color: Colors.black),
                    ),
                ]
            ),
        )
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
      child:Column(
        children:
        [
          if(model.image!=null)
            model.image!=''?Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration:  BoxDecoration(
                image: DecorationImage(image: NetworkImage(model.image!)),
                color: Colors.red,
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10)),
              ),
            ) :Center(child: CircularProgressIndicator()),
          Text(model.text!)
        ],
      )
      );
}
