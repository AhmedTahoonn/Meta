class MessageModel
{
  String ?senderId;
  String ?reciverId;
  String ?dateTime;
  String ?text;
  String ?image;

  MessageModel({
   this.text,
    this.dateTime,
    this.senderId,
    this.reciverId,
    this.image

  });
  MessageModel.fromJson(Map<String,dynamic>json)
  {
    text=json['text'];
    dateTime=json['dateTime'];
    senderId=json['senderId'];
    reciverId=json['reciverId'];
    reciverId=json['image'];






  }
  Map<String, dynamic> toMap()  {
    return{
      'text':text,
      'dateTime':dateTime,
      'senderId':senderId,
      "reciverId":reciverId,
      'image':image,


    };
  }

}