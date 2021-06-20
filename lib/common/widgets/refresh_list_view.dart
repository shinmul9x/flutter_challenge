import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefreshListView extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final List<Widget> children;
  final VoidCallback? onRefesh;
  final VoidCallback? onLoadMore;

  RefreshListView({
    this.padding = EdgeInsets.zero,
    required this.children,
    this.onRefesh,
    this.onLoadMore,
  });

  @override
  _RefreshListViewState createState() => _RefreshListViewState();
}

class _RefreshListViewState extends State<RefreshListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onBottomList);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onBottomList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefesh == null) return _child;

    return RefreshIndicator(
      child: _child,
      onRefresh: () async {
        widget.onRefesh?.call();
      },
    );
  }

  Widget get _child {
    return Container(
      height: Get.height,
      child: ListView(
        shrinkWrap: true,
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: widget.padding,
        children: widget.children,
      ),
    );
  }

  void _onBottomList() {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0) {
        widget.onLoadMore?.call();
      }
    }
  }
}
