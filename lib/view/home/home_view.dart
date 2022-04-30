import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/view/home/home_viewmodel.dart';
import 'package:zweeck/view/post/post_view.dart';
import 'package:zweeck/view/user/user_view.dart';

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
    return model.readyFlag
        ? model.error == null
            ? _buildView(context, model)
            : _buildErrorDialog(context, model)
        : _buildSplashScreen(context, model);
  }

  Widget _buildSplashScreen(BuildContext context, HomeViewModel model) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/flutter_logo.jpg"),
      ),
    );
  }

  Widget _buildErrorDialog(BuildContext context, HomeViewModel model) {
    return Scaffold(
      body: Center(
        child: Text("Error: ${model.error!.statusCode}"),
      ),
    );
  }

  Widget _buildView(BuildContext context, HomeViewModel model) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) => Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.auto_awesome,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: const TabBarView(
              children: [
                PostView(
                  filter: "F",
                ),
                PostView(
                  filter: "S",
                ),
                UserView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
