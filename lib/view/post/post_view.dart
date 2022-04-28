import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
    return const Center(child: Text("PostView works!"));
  }
}
