import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) => model.init(context),
      builder: _uiBuilder,
    );
  }

  Widget _uiBuilder(BuildContext context, HomeViewModel model, Widget? child) {
    // create TabBar
    return Scaffold(
      body: Center(
        child: model.completionFlag
            ? _loadHome(context, model)
            : _splashScreen(context, model),
      ),
    );
  }

  Widget _splashScreen(BuildContext context, HomeViewModel model) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/flutter_logo.jpg"),
      ),
    );
  }

  Widget _loadHome(BuildContext context, HomeViewModel model) {
    if (model.error != null) {
      return Text("${model.error!.code}");
    } else {
      return const Text("Home works");
    }
  }
}
