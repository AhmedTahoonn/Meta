/// abstract class
abstract class HomePageStates{}
////////////////////////////////////////////////////////////////////////////////
/// Initial state
class HomePageInitialState extends HomePageStates {}
////////////////////////////////////////////////////////////////////////////////
/// change bottomNavigationBar state
class ChangeBottomNavigationBarState extends HomePageStates {}
////////////////////////////////////////////////////////////////////////////////
/// Get user data
 class SocialGetUserSuccessState extends HomePageStates {}
 class SocialGetUserErrorState extends HomePageStates {}
 class SocialGetUserLoadingState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// Update user data
 class SocialUserUpdateErrorState extends HomePageStates {}
 class SocialUserUpdateLoadingState extends HomePageStates {}
 class SocialUserUpdateScuessState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// pick profile image
 class SocialPickedProfilePhotoSuccessState extends HomePageStates {}
 class SocialPickedProfilePhotoErrorState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// pick cover image
 class SocialPickedCoverPhotoSuccessState extends HomePageStates {}
 class SocialPickedCoverPhotoErrorState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// Upload cover image
 class SocialUploadCoverPhotoLoadingState extends HomePageStates {}
 class SocialUploadCoverPhotoSuccessState extends HomePageStates {}
 class SocialUploadCoverPhotoErrorState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// Upload profile image
 class SocialUploadProfilerPhotoLoadingState extends HomePageStates {}
 class SocialUploadProfilerPhotoSuccessState extends HomePageStates{}
 class SocialUploadProfilePhotoErrorState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// Get all users
 class SocialGetAllUserSuccessState extends HomePageStates {}
 class SocialGetAllUserErrorState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
 class moveTOAddNewState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// pick image post
 class SocialPickImagePostSuccessState extends HomePageStates {}
 class SocialPickImagePostErrorState extends HomePageStates {}
 //////////////////////////////////////////////////////////////////////////////
/// remove Pick post image
 class SocialRemovePostImageState extends HomePageStates {}
 //////////////////////////////////////////////////////////////////////////////
/// create post
 class SocialCreatePostLoadingState extends HomePageStates {}
 class SocialCreatePostErrorState extends HomePageStates {}
 class SocialCreatePostSuccessState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
///Get posts
 class SocialGetPostSuccessState extends HomePageStates {}
 class SocialGetPostErrorState extends HomePageStates {}
 //////////////////////////////////////////////////////////////////////////////
/// Send Message
 class SocialSendMessageSuccessState extends HomePageStates {}
 class SocialSendMessageErrorState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// Get Message
 class SocialGetMessageSuccessState extends HomePageStates {}
//////////////////////////////////////////////////////////////////////////////
///Change Password
 class SocialChangePasswordErrorState extends HomePageStates {}
 class SocialChangePasswordSuccessState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
///Delete post
 class SocialDeletePostErrorState extends HomePageStates {}
 class SocialDeletePostSuccessState extends HomePageStates {}
 ///////////////////////////////////////////////////////////////////////////////
/// pick my photo
class SocialPickedMyPhotoSuccessState extends HomePageStates {}
class SocialPickedMyPhotoErrorState extends HomePageStates {}
///////////////////////////////////////////////////////////////////////////////
/// upload my photo
 class SocialUploadPhotoErrorState extends HomePageStates {}
 class SocialUploadPhotoSuccessState extends HomePageStates {}
 class SocialUploadPhotoLoadingState extends HomePageStates {}
 //////////////////////////////////////////////////////////////////////////////
///Get my photo
 class SocialGetMyPhotoSuccessState extends HomePageStates {}
 class SocialGetMyPhotoErrorState extends HomePageStates {}
 //////////////////////////////////////////////////////////////////////////////
///Delete my photos
 class SocialDeletePhotoErrorState extends HomePageStates {}
 class SocialDeletePhotoSuccessState extends HomePageStates {}
 ////////////////////////////////////////////////////////////////////////////////////
/// create post
class SocialLikePostLoadingState extends HomePageStates {}
class SocialLikePostErrorState extends HomePageStates {}
class SocialLikePostSuccessState extends HomePageStates {}
//////////////////////////////////////////////////////////////////////////////
/// remove Pick post image
class SocialRemoveMyPhotoState extends HomePageStates {}
//////////////////////////////////////////////////////////////////////////////
/// logout
class LogoutErrorState extends HomePageStates {}
class LogoutSuccessState extends HomePageStates {}
///////////////////////////////////////////////////////////////////////////////
/// Upload Chat image
class SocialUploadChatPhotoLoadingState extends HomePageStates {}
class SocialUploadChatPhotoSuccessState extends HomePageStates {}
class SocialUploadChatPhotoErrorState extends HomePageStates {}
///////////////////////////////////////////////////////////////////////////////////
/// pick Chat image
class SocialPickedChatPhotoSuccessState extends HomePageStates {}
class SocialPickedChatPhotoErrorState extends HomePageStates {}