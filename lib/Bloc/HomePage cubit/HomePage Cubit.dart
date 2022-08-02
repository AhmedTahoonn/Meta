import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mysocialapp/sharedPrefences/cachHelper.dart';
import '../../Constant/constant.dart';
import '../../models/UserModell/userModel.dart';
import '../../models/message model/model message.dart';
import '../../models/post model/model post.dart';
import '../../modules/BottomNavigationBar Module/Home Page/page1.dart';
import '../../modules/BottomNavigationBar Module/chat page/chats.dart';
import '../../modules/BottomNavigationBar Module/post page/post.dart';
import '../../modules/BottomNavigationBar Module/profile page/page4.dart';
import '../../modules/login page/Login_Screen.dart';
import 'HomePage States.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  String ?Recivver;
  List<Widget> screens = [
    page1(),
    post_Screen(),
    Chats(),
    page4(),

  ];
  List<String>titles=[
    'My Social',
    'post',
     'Chats',
    'My Profile',

  ];
////////////////////////////////////////////////////////////////////////////////
  /// Change BottomNavigationBar
  void changeBottomNavigationBar(int value) {

    if(value==2)
    {
      getUsers();
    }
    if(value==3)
      {
        myPhoto();
      }
    if (value == 1) {
      emit(moveTOAddNewState());
    }

    else {
      currentIndex = value;
      emit(ChangeBottomNavigationBarState());
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get User data
  UserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.data());
      }
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialGetUserErrorState());
    });
  }
////////////////////////////////////////////////////////////////////////////////
  ///Update User data
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    required String email,

    String ?cover,
    String ?profile

  }) {
    // emit(SocialUserUpdateLoadingState());
    {
      userModel = UserModel(
        name: name,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        bio: bio,
        email: email,
        cover: cover ?? userModel!.cover,
        profile: profile ?? userModel!.profile,
      );
      FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(
          userModel!.toMap()).then((value) {
        getUserData();
        emit(SocialUserUpdateScuessState());
      }).catchError((error) {
        emit(SocialUserUpdateErrorState());
      });
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Pick Profile Image
  var picker = ImagePicker();
  File ?profileImage;

  Future<void> pickProfileImage() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      profileImage = File(response.path);
      emit(SocialPickedProfilePhotoSuccessState());
    }
    else {
      if (kDebugMode) {
        print(' No image selected');
      }
      emit(SocialPickedProfilePhotoErrorState());
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Pick Cover Image
  File ?coverImage;
  Future<void> pickCoverImage() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      coverImage = File(response.path);
      emit(SocialPickedCoverPhotoSuccessState());
    }
    else {
      if (kDebugMode) {
        print(' No image selected');
      }
      emit(SocialPickedCoverPhotoErrorState());
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Upload Profile Image
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    required String email
  }) {
    emit(SocialUploadProfilerPhotoLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}').putFile(profileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, profile: value, email:email);

        emit(SocialUploadProfilerPhotoSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(SocialUploadProfilePhotoErrorState());
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialUploadProfilePhotoErrorState());
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Upload Cover Image

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    required String email
  }) {
    emit(SocialUploadCoverPhotoLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}').putFile(coverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        // emit(SocialUploadImageCoverSucessState());
        updateUser(name: name, phone: phone, bio: bio, cover: value,email: email);
        emit(SocialUploadCoverPhotoSuccessState());

      }).catchError((error) {
        emit(SocialUploadCoverPhotoErrorState());

      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialUploadCoverPhotoErrorState());
    });
  }

  ////////////////////////////////////////////////////////////////////////////////
  /// Add MY Photo
  File ?addPhoto;
  Future<void> pickAddPhoto() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      addPhoto = File(response.path);
      emit(SocialPickedMyPhotoSuccessState());
    }
    else {
      if (kDebugMode) {
        print(' No image selected');
      }
      emit(SocialPickedMyPhotoErrorState());
    }
  }
  /////////////////////////////////////////////////////////////////////////////
  ///Create New photo
  void createNewPhoto({
    required String dateTime,
    required String text,
    String ?AddPhoto,


  }) {
    emit(SocialUploadPhotoLoadingState());
    {
      PostModel model = PostModel(
          name: userModel!.name,
          profile: userModel!.profile,
          uId: userModel!.uId!,
          date: dateTime,
          text: text,
          postImage: AddPhoto ?? ''

      );
      FirebaseFirestore.instance.collection('photos').doc(userModel!.uId).set(model.toMap()).then((
          value) {
        emit(SocialUploadPhotoSuccessState());
      }).catchError((error) {
        emit(SocialUploadPhotoErrorState());
      });
    }
  }
  /////////////////////////////////////////////////////////////////////////////
  ///upload photo
  void uploadNewPhotoImage({

    required String dateTime,
    required String text,
    required dynamic context,


  }) {
    emit(SocialUploadPhotoLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('photos/${Uri
        .file(addPhoto!.path)
        .pathSegments
        .last}').putFile(addPhoto!).then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        createNewPhoto(dateTime: dateTime, text: text, AddPhoto: value);
        Fluttertoast.showToast(
            msg: 'Add Successfully ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        myPhoto();
        Navigator.pop(context);
        emit(SocialUploadPhotoSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }

      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialUploadPhotoErrorState());
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get my photos

////////////////////////////////////////////////////////////////////////////////
  ///Delete my photo
  void deletePhoto({
    required dynamic photoId,
    required dynamic context,
  })
  {
    FirebaseFirestore.instance.collection('photos').doc(photoId).delete().then((value) {
      emit(SocialDeletePhotoSuccessState());
      Navigator.pop(context);

    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialDeletePhotoErrorState());

    });
  }
  /////////////////////////////////////////////////////////////////////////////
  void removePickImage()
  {
    addPhoto = null;
    emit(SocialRemovePostImageState());
  }

  //////////////////////////////////////////////////////////////////////////////

  ///Get All Users
  List<UserModel> users = [];
  void getUsers() {
    users = [];
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId']!=userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState());
      });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Pick Post Image
  File ?postImage;
  Future<void> pickPostImage() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      postImage = File(response.path);
      emit(SocialPickImagePostSuccessState());
    }
    else {
      print(' No image selected');
      emit(SocialPickImagePostErrorState());
    }
  }
  /////////////////////////////////////////////////////////////////////////////
  /// Remove Pick Post Image
  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }
  //////////////////////////////////////////////////////////////////////////////
  /// upload post Image
  void uploadNewPostImage({
    required String dateTime,
    required String text,
    required dynamic context,


  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}').putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        createPost(dateTime: dateTime, text: text, postImage: value,context: context);
        Fluttertoast.showToast(
            msg: 'Add post Successfully ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        Navigator.pop(context);


      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialCreatePostErrorState());
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Create Post
  void createPost({
    required String dateTime,
    required String text,
    required dynamic context,
    String ?postImage,


  }) {
    emit(SocialCreatePostLoadingState());
    {
      PostModel model = PostModel(
          name: userModel!.name,
          profile: userModel!.profile,
          uId: userModel!.uId!,
          date: dateTime,
          text: text,
          postImage: postImage ?? ''
      );
      FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((
          value) {
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }
  }
  //////////////////////////////////////////////////////////////////////////////
  List<PostModel> posts = [];
  List<String>postIdAll = [];
  List<PostModel> myPhotos = [];
  List<PostModel> friendsPhotos = [];
  List<String>photoIdAll = [];
  List<String>myPhotoIdAll = [];
  List<int>likes = [];
  List<int>comments = [];
////////////////////////////////////////////////////////////////////////////////
  /// Get Posts
  void getPosts() {

    FirebaseFirestore.instance.collection('posts').orderBy('date',descending: true).snapshots().listen((value) {

      posts=[];
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {
          emit(SocialGetPostErrorState());
        });

        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          if (kDebugMode) {
            print("ffffffffff"+element.id);
          }
          postIdAll.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {
          emit(SocialGetPostErrorState());
        });
      });
      emit(SocialGetPostSuccessState());

    });

  }
  //////////////////////////////////////////////////////////////////////////////
  /// Send message
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,

  })
  {
    MessageModel model=MessageModel(
      text: text,
      senderId: userModel!.uId,
      reciverId: receiverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).collection('chats').doc(receiverId).collection('messages').add(model.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());

    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(userModel!.uId).collection('messages').add(model.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }
////////////////////////////////////////////////////////////////////////////////
  ///Get message
  var messageController=TextEditingController();
  List<MessageModel>messages=[];
  void getMessage({
    required String receiverId,
  })
  {
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).collection('chats').doc(receiverId).collection('photos').orderBy('dateTime').snapshots().listen((event) {
      messages=[];


      event.docs.forEach((element) {
        print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessageSuccessState());
    });

  }
  /////////////////////////////////////////////////////////////////////////////
  /// Change password
  void changePassword({
    required String newPassword,
    required dynamic context,
  })
  {
    FirebaseAuth.instance.currentUser!.updatePassword(newPassword).then((value) {

      FirebaseAuth.instance.signOut();
      CacheHelper.remove(key: 'uId').then((value) {
        Fluttertoast.showToast(
            msg: 'Password Change Successfully ,Please login Again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        emit(SocialChangePasswordSuccessState());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => false);


      });
    }).catchError((error){
      emit(SocialChangePasswordErrorState());
       if (kDebugMode) {
         print(error.toString());
       }
    });
  }
  ////////////////////////////////////////////////////////////////////////////
  /// Delete Post
void deletePost({
  required dynamic postId,
})
{
  FirebaseFirestore.instance.collection('posts').doc(postId).delete().then((value) {
    emit(SocialDeletePostSuccessState());

}).catchError((error){
emit(SocialDeletePostErrorState());

});
}

  ///////////////////////////////////////////////////////////////////////////////
  /// like post
void likePost({
  required String postId,
})
{
  FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userModel!.uId).set({
    'like':true,
  }).then((value) {
    emit(SocialLikePostSuccessState());
  }).catchError((error){
    emit(SocialLikePostErrorState());
  });
}

  void userPhotos({
    required String receiverId,

  }) {
    friendsPhotos=[];
    FirebaseFirestore.instance.collection('photos').doc(receiverId).get().then((value) {
      photoIdAll.add(value.id);
      friendsPhotos.add(PostModel.fromJson(value.data()!));
      if (kDebugMode) {
        print("sssssssssss${value.data()}");
      }

      emit(SocialGetMyPhotoSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialGetMyPhotoErrorState());
    });
  }
  void myPhoto() {
    myPhotos=[];
    FirebaseFirestore.instance.collection('photos').doc(uId).get().then((value) {
      myPhotoIdAll.add(value.id);
      myPhotos.add(PostModel.fromJson(value.data()!));
      if (kDebugMode) {
        print("sssssssssss${value.data()}");
      }

      emit(SocialGetMyPhotoSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialGetMyPhotoErrorState());
    });
  }

void logout({
  required dynamic context,
})
{
  FirebaseAuth.instance.signOut().then((value) {
    CacheHelper.remove(key: 'uId').then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => true);
      currentIndex=0;

    }).catchError((error){

    });

    emit(LogoutSuccessState());
  }).catchError((error){
    emit(LogoutErrorState());

  });
}
  void uploadChatImage({
   required String receiverId,
    required String text,
    required String dateTime,

  }) {
    emit(SocialUploadChatPhotoLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('ChatImages/${Uri
        .file(ChatImage!.path)
        .pathSegments
        .last}').putFile(ChatImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        sendChatPhoto(
          image:value,
          receiverId: receiverId,
          text:text,
          dateTime: dateTime
        );
        Fluttertoast.showToast(
            msg: 'Add Successfully ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        emit(SocialUploadChatPhotoSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }

      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialUploadChatPhotoErrorState());
    });
  }
  /////////////////////////////////////////////////////////////////////////////////
  /// Pick Chat Image
  File ?ChatImage;

  Future<void> pickChatImageCamera() async {
    final response = await picker.pickImage(source: ImageSource.camera);
    if (response != null) {
      ChatImage = File(response.path);
      emit(SocialPickedChatPhotoSuccessState());
    }
    else {
      if (kDebugMode) {
        print(' No image selected');
      }
      emit(SocialPickedChatPhotoErrorState());
    }
  }
  Future<void> pickChatImageGallery() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response!=null) {
      ChatImage = File(response.path);
      emit(SocialPickedChatPhotoSuccessState());
    }
    else {
      if (kDebugMode) {
        print(' No image selected');
      }
      emit(SocialPickedChatPhotoErrorState());
    }
  }
  ///Create Send Chat photo
  void sendChatPhoto({
    required String receiverId,
  required String image,
      required String text,
    required String dateTime,

  }) {
    MessageModel model=MessageModel(
      text: text,
      senderId:userModel!.uId,
      reciverId:receiverId,
      dateTime:dateTime,
      image:image
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).collection('chats').doc(receiverId).collection('photos').add(model.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());

    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(userModel!.uId).collection('photos').add(model.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

}

