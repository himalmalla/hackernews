import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/commentmodel.dart';


final commentCall = Provider((ref) => CommentProvider());

final commentProvider = Provider((ref) => commentList);

List<CommentModel> commentList = [];

class CommentProvider {
  Future<void> getComment({List? kids}) async {
    try{
      final dio = Dio();
      if(kids != null) {
        for (int i = 0; i < kids.length; i++) {
          int id = await kids[i];

          final comments = await dio.get('https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
        Map<String, dynamic> map = await comments.data;
        final data = await CommentModel.fromJson(map);
        commentList.add(data);
        }
      }
    } catch (e){
      print(e);
    }
  }
}