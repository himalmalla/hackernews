import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hackernews/provider/comment_provider.dart';
import 'package:hackernews/provider/topstory_provider.dart';
import 'package:hackernews/screen/comment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Hacker News'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final data = ref.watch(topStoryProvider);
        return data.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(data[index].title!, style: const TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].url == null
                            ? "No Url"
                            : data[index].url!),
                        data[index].kids?.length == null
                            ? const Text("")
                            : TextButton(
                                onPressed: () async {
                                  await ref
                                      .read(commentCall)
                                      .getComment(kids: data[index].kids);
                                  Get.to(() => CommentScreen(news: data[index]),
                                      transition: Transition.downToUp);
                                },
                                child: const Text('view comment'),
                              ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        const Icon(Icons.comment_rounded),
                        Text(data[index].kids?.length == null
                            ? '0'
                            : data[index].kids!.length.toString()),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (err, stack) => Text('$err'),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
