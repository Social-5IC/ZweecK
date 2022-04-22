import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) => model.init(),
      builder: _uiBuilder,
    );
  }

  Widget _uiBuilder(BuildContext context, HomeViewModel model, Widget? child) {
    // create TabBar
    return Scaffold(
      body: Center(
        child: model.errorFlag
            ? Text("${model.error!.error}")
            : const CircularProgressIndicator(),
      ),
    );
  }
}
