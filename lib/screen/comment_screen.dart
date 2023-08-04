import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/TopStoriesModel.dart';
import '../provider/comment_provider.dart';

class CommentScreen extends StatelessWidget {
  final TopStories news;
  CommentScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text(news.title!),
                subtitle: Text(news.url!),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Comment Section",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              child: Consumer(
                builder: (context, ref, child) {
                  final comment = ref.watch(commentProvider);
                  return ListView.builder(
                    itemCount: comment.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          comment[index].by == null
                              ? "Unnknown User"
                              : comment[index].by!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(comment[index].text == null
                            ? "Nothing"
                            : comment[index].text!),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
