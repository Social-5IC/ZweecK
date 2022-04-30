import 'package:flutter/material.dart';

class ExtendableListView extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int maxExtent;
  final Future Function() onExtend;

  const ExtendableListView.builder({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    required this.maxExtent,
    required this.onExtend,
  }) : super(key: key);

  @override
  State<ExtendableListView> createState() => _ExtendableListViewState();
}

class _ExtendableListViewState extends State<ExtendableListView> {
  late final ScrollController controller;
  bool fetching = false;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.extentAfter < widget.maxExtent && !fetching) {
      fetching = true;
      setState(() {
        widget.onExtend();
      });
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          fetching = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      controller: controller,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }
}
