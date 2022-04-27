import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/welcome/welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      onModelReady: (WelcomeViewModel model) => model.init(),
      builder: _uiBuilder,
    );
  }

  Widget _uiBuilder(
      BuildContext context, WelcomeViewModel model, Widget? child) {
    // create TabBar
    return const Scaffold(
      body: Center(
        child: Text("WelcomeView works"),
      ),
    );
  }
}
