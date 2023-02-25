class PostModel{
  String? uid;
  String? title;
  String? discription;
  String? video;


  PostModel({this.uid, this.title, this.discription, this.video});

  PostModel.fromMap(Map<String, dynamic>map){
    uid = map['uid'];
    title = map['title'];
    discription = map['discription'];
    video = map['video'];
  }

  Map<String,dynamic>toMap(){
    return {
      'uid': uid,
      'title': title,
      'discription' :discription,
      'video' : video
    };
  }

}