import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/welcome/components/sign_up_form.dart';
import 'package:zweeck/view/welcome/welcome_viewmodel.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: _uiBuilder,
    );
  }

  Widget _uiBuilder(
    BuildContext context,
    WelcomeViewModel model,
    Widget? child,
  ) {
    // create TabBar
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: RepaintBoundary(
              child: SignUpForm(
                onSubmit: model.signUp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
