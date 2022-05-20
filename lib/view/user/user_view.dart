import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/view/post/post_view.dart';
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
    return model.readyFlag
        ? model.error == null
            ? _buildView(context, model)
            : _buildErrorDialog(context, model)
        : _buildLoading(context, model);
  }

  Widget _buildLoading(BuildContext context, UserViewModel model) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorDialog(BuildContext context, UserViewModel model) {
    return Center(
      child: Text("Error: ${model.error!.statusCode}"),
    );
  }

  Widget _buildView(BuildContext context, UserViewModel model) {
    User user = model.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(user.username),
              ],
            ),
          ),
          collapsed: Container(),
          expanded: _buildSettings(context, model),
          theme: const ExpandableThemeData(
            collapseIcon: Icons.settings,
            expandIcon: Icons.settings,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
        ),
        _buildUserInfo(context, "Name", user.name),
        _buildUserInfo(context, "Surname", user.surname),
        _buildUserInfo(context, "Mail", user.mail),
        _buildUserInfo(context, "Sex", user.sex),
        const Expanded(child: PostView(filter: "Y"))
      ],
    );
  }

  Widget _buildSettings(BuildContext context, UserViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            height: 25,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            child: const Text("Settings"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  model.logout(context);
                },
                child: const Text("logout"),
              ),
              ElevatedButton(
                onPressed: () {
                  model.deleteUser(context);
                },
                child: const Text("delete user"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, String placeholder, String info) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(bottom: 5, left: 10),
      height: 40,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            placeholder,
            style: const TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 12,
            ),
          ),
          Text(info)
        ],
      ),
    );
  }
}
