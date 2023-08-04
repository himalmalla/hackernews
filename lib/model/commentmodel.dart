

class CommentModel {
  String? by;
  int? id;
  List? kids;
  int? parent;
  String? text;
  int? time;
  String? type;

  CommentModel ({
  this.by,
    this.id,
    this.kids,
    this.parent,
    this.text,
    this.time,
    this.type
});

  factory CommentModel.fromJson(Map<String, dynamic> json){
    return CommentModel(
      by: json['by'],
      id: json['id'],
      kids: json['kids'],
      parent: json['parent'],
      text: json['text'],
      time: json['time'],
      type: json['type']
    );
  }


}