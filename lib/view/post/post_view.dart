import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/view/post/components/extendable_list_view.dart';
import 'package:zweeck/view/post/post_viewmodel.dart';

class PostView extends StatelessWidget {
  final String filter;

  const PostView({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PostViewModel(),
      onModelReady: (PostViewModel model) => model.init(filter),
      builder: _uiBuilder,
    );
  }

  Widget _uiBuilder(BuildContext context, PostViewModel model, Widget? child) {
    String title = "";
    switch (filter) {
      case "F":
        title = "Your following posts";
        break;
      case "S":
        title = "Suggested for you";
        break;
      case "Y":
        title = "Your posts";
        break;
    }

    List<Post> posts = model.posts;

    return Column(
      children: [
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          child: Text(title),
        ),
        Expanded(
          child: ExtendableListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Post post = posts[index];

              return SizedBox(
                height: 200,
                child: Text(post.description),
              );
            },
            maxExtent: 500,
            onExtend: () async {
              await model.retrievePosts();
            },
          ),
        )
      ],
    );
  }
}
