import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocialapp/Bloc/HomePage%20cubit/HomePage%20Cubit.dart';
import 'package:mysocialapp/Bloc/HomePage%20cubit/HomePage%20States.dart';
import 'package:mysocialapp/models/UserModell/userModel.dart';
import 'package:mysocialapp/styles/icon_broken.dart';

class SendChatImage extends StatelessWidget {
  UserModel? userModel;

  SendChatImage({
    this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: IconButton(
              onPressed: () {
                HomePageCubit.get(context).uploadChatImage(
                  receiverId: HomePageCubit.get(context).Recivver!,
                  dateTime: DateTime.now().toString(),
                  text: 'aa',


                );
              },
              icon: Icon(IconBroken.Send),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.black,
                )),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              FileImage(HomePageCubit.get(context).ChatImage!)),
                    )),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if(state is SocialUploadChatPhotoSuccessState)
          {
            Navigator.pop(context);
          }
      },
    );
  }
}
