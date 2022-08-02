class AddNewPhotoModel
{
  String ?name;
  String ?uId;
  String? profile;
  String ?date;
  String? text;
  String ? addNewPhoto;
  AddNewPhotoModel({
    required this.uId,
    this.name,
    this.profile,
    this.date,
    this.text,
    this.addNewPhoto,


  });
  AddNewPhotoModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    date=json['date'];
    uId=json['uId'];
    text=json['text'];
    profile=json['profile'];
    addNewPhoto=json['addNewPhoto'];




  }
  Map<String, dynamic> toMap()  {
    return{
      'name':name,
      'date':date,
      "uId":uId,
      'text':text,
      'profile':profile,
      'postImage':addNewPhoto,

    };
  }

}