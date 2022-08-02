class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? profile;
  String? cover;
  String? bio;


  UserModel({required this.name, required this.email, required this.phone, required this.uId, required this.isEmailVerified,
    required this.profile, required this.cover, required this.bio});

  UserModel.fromJson(Map<String,dynamic>json)
  {
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];
    profile=json['profile'];
    bio=json['bio'];
    cover=json['cover'];




  }
  Map<String, dynamic> toMap()  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      "uId":uId,
      'isEmailVerified':isEmailVerified,
      'profile':profile,
      'bio':bio,
      'cover':cover,

    };
  }

}
