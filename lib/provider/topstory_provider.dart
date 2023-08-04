import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/TopStoriesModel.dart';

final topStoryProvider = FutureProvider((ref) => TopStoryProvider().getStoryDetail());
late List idList = [];
List<TopStories> storiesList = [];

class TopStoryProvider {
  Future<List<TopStories>> getStoryDetail() async {
    try {
      final dio = Dio();
      
      final response = await dio.get('https://hacker-news.firebaseio.com/v0/topstories.json?');
      if (response.statusCode == 200){
        idList = response.data;
        print(idList.length);
        for (int i = 0; i<12; i++){
          int id = idList[i];
          final stories = await dio.get('https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
          Map<String, dynamic> map = stories.data;
          final data = TopStories.fromJson(map);
          storiesList.add(data);
        }
      }
      return storiesList;
    } catch (e){
      throw e;
    }
    
  }
  
  
}