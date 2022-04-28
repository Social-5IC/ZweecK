import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/user/user_viewmodel.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserViewModel(),
      onModelReady: (UserViewModel model) => model.init(),
      builder: _uiBuilder,
    );
  }

  Widget _uiBuilder(BuildContext context, UserViewModel model, Widget? child) {
    return const Center(child: Text("UserView works!"));
  }
}
