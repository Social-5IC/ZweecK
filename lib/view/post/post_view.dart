import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/view/post/components/create_post_form.dart';
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
    List<Post> posts = model.posts;

    return Column(
      children: [
        _buildHeader(context, model),
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
                  child: Text(model.emptyListPlaceHolder),
                ),
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext context, PostViewModel model) {
    return !model.personalZone
        ? Container(
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            child: Text(model.title),
          )
        : ExpandablePanel(
            header: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Text(model.title),
            ),
            collapsed: Container(),
            expanded: CreatePostForm(
              onSubmit: model.createPost,
            ),
            theme: const ExpandableThemeData(
              collapseIcon: Icons.add,
              expandIcon: Icons.add,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
          );
  }

  Widget _buildPost(BuildContext context, PostViewModel model, Post post) {
    return LimitedBox(
      maxHeight: 1000,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FadeInImage(
          //   fadeInDuration: const Duration(milliseconds: 1),
          //   fadeInCurve: Curves.easeInOutQuint,
          //   placeholder: MemoryImage(kTransparentImage),
          //   image: MemoryImage(
          //     base64Decode(post.image),
          //   ),
          // ),
          Stack(children: [
            Image.memory(base64Decode(post.image)),
            if (model.personalZone)
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  splashRadius: 20,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    model.deletePost(post.key);
                  },
                  icon: const Icon(Icons.remove),
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(post.description),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
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
            ),
          )
        ],
      ),
    );
  }
}
