import 'dart:convert';

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
    return model.readyFlag
        ? model.error == null
            ? _buildView(context, model)
            : _buildErrorDialog(context, model)
        : _buildLoading(context, model);
  }

  Widget _buildLoading(BuildContext context, PostViewModel model) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorDialog(BuildContext context, PostViewModel model) {
    return Center(
      child: Text("Error: ${model.error!.statusCode}"),
    );
  }

  Widget _buildView(BuildContext context, PostViewModel model) {
    String title = "";
    String emptyListPlaceHolder = "";
    switch (filter) {
      case "F":
        title = "Your following posts";
        emptyListPlaceHolder = "Follow someone!";
        break;
      case "S":
        title = "Suggested for you";
        emptyListPlaceHolder = "Nothing for you yet!";
        break;
      case "Y":
        title = "Your posts";
        emptyListPlaceHolder = "No post";
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
          child: posts.isNotEmpty
              ? ExtendableListView.builder(
                  maxExtent: 500,
                  onExtend: model.retrievePosts,
                  itemCount: posts.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildPost(context, model, posts[index]),
                )
              : Center(
                  child: Text(emptyListPlaceHolder),
                ),
        )
      ],
    );
  }

  Widget _buildPost(BuildContext context, PostViewModel model, Post post) {
    return LimitedBox(
      maxHeight: 1000,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(post.description),
            // FadeInImage(
            //   fadeInDuration: const Duration(milliseconds: 1),
            //   fadeInCurve: Curves.easeInOutQuint,
            //   placeholder: MemoryImage(kTransparentImage),
            //   image: MemoryImage(
            //     base64Decode(post.image),
            //   ),
            // ),
            Image.memory(base64Decode(post.image)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${post.likes} likes"),
                ElevatedButton(
                  onPressed: () {
                    post.youLiked
                        ? model.dropLike(post.key)
                        : model.likePost(post.key);
                  },
                  child: Icon(
                    post.youLiked ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
