import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Bloc/HomePage cubit/HomePage Cubit.dart';
import '../../../Bloc/HomePage cubit/HomePage States.dart';
import '../../../models/UserModell/userModel.dart';

import '../../../styles/icon_broken.dart';
import 'change password.dart';

class editProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (context, state) {
        if (state is SocialUserUpdateScuessState) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Fluttertoast.showToast(
              msg: 'Update Successfully',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 8,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        UserModel usermodel = HomePageCubit.get(context).userModel!;

        nameController.text = usermodel.name!;
        bioController.text = usermodel.bio!;
        phoneController.text = usermodel.phone!;
        emailController.text=usermodel.email!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'Edit profile',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if(formKey.currentState!.validate())
                      {
                        HomePageCubit.get(context).updateUser(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text);

                      }
                  },
                  child: const Text('UPDATE')),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6)),
                                    image: DecorationImage(
                                      image:HomePageCubit.get(context).coverImage==null ?NetworkImage(
                                          '${HomePageCubit.get(context).userModel!.cover}'):FileImage(HomePageCubit.get(context).coverImage!)as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    HomePageCubit.get(context).pickCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(Icons.camera_alt),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: HomePageCubit.get(context)
                                            .profileImage ==
                                        null
                                    ? NetworkImage(
                                        '${HomePageCubit.get(context).userModel!.profile}')
                                    : FileImage(HomePageCubit.get(context)
                                        .profileImage!) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                HomePageCubit.get(context).pickProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if(HomePageCubit.get(context).profileImage!=null||HomePageCubit.get(context).coverImage!=null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: Row(
                      children: [
                        if(HomePageCubit.get(context).profileImage!=null)

                          Expanded(
                          child: Column(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                  {
                                    HomePageCubit.get(context).uploadProfileImage(name: nameController.text.trim(), phone: phoneController.text.trim(), bio: bioController.text.trim(),email: emailController.text.trim());

                                  }                                },
                                child: const Text('Upload Profile Image'),
                              ),
                              if(state is SocialUploadProfilerPhotoLoadingState)
                              const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if(HomePageCubit.get(context).coverImage!=null)

                          Expanded(
                          child: Column(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                    {
                                      HomePageCubit.get(context).uploadCoverImage(name: nameController.text.trim(), phone: phoneController.text.trim(), bio: bioController.text.trim(),email: emailController.text.trim());

                                    }

                                },
                                child: const Text('Upload Cover Image'),
                              ),
                              if(state is SocialUploadCoverPhotoLoadingState)

                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('PERSONAL INFORMATION',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,fontStyle: FontStyle.italic),),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(2, 2))
                        ]),
                    child: TextFormField(
                      controller:nameController,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your name address..";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: const Icon(
                            IconBroken.Profile,
                          ),
                          // border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(2, 2))
                        ]),
                    child: TextFormField(

                      controller:emailController,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your Email Address ..";
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                          hintText: "Email Address",
                          prefixIcon: const Icon(
                            IconBroken.Message,
                          ),
                          // border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(2, 2))
                        ]),
                    child: TextFormField(
                      controller: phoneController,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your bio address..";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Bio",
                          prefixIcon: const Icon(
                            IconBroken.Call,
                          ),
                          // border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(2, 2))
                        ]),
                    child: TextFormField(
                      controller: bioController,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter your bio ..";
                        }
                        return null;
                      },
                      maxLines:null,

                      decoration: InputDecoration(

                          hintText: "Bio",
                          prefixIcon: const Icon(
                            Icons.edit_location_outlined,
                          ),
                          // border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 3),
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      width: double.infinity,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('SECURITY INFORMATION',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w800,fontStyle: FontStyle.italic),),
                          const SizedBox(height: 5,),
                          OutlinedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => changePassword(),));

                              },
                              child: const Text('Change Password')
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: InkWell(
                        onTap: (){

                            HomePageCubit.get(context).logout(context: context);

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          const [
                            Icon(IconBroken.Logout),
                            SizedBox(width: 10,),
                            Text('SignOut',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),)
                          ],
                        ),
                      ),
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
}
