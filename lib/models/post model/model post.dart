class PostModel
{
  String ?name;
  late String uId;
  String? profile;
  String ?date;
  String? text;
  String ? postImage;
  PostModel({
     required this.uId,
    this.name,
    this.profile,
    this.date,
    this.text,
    this.postImage,


  });
  PostModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    date=json['date'];
    uId=json['uId'];
    text=json['text'];
    profile=json['profile'];
    postImage=json['postImage'];




  }
  Map<String, dynamic> toMap()  {
    return{
      'name':name,
      'date':date,
      "uId":uId,
      'text':text,
      'profile':profile,
      'postImage':postImage,

    };
  }

}