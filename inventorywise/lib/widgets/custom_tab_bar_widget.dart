import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatefulWidget {
  const CustomTabBarWidget(
      {Key? key,
      required this.children,
      required this.labels,
      this.backgroundColor,
      this.tabBarHeight,
      this.aspectRatio = 1 / 2,
      this.useAspectRatioToSolveLayout = false,
      this.tabBarHorizontalPadding = 10})
      : super(key: key);
  final double tabBarHorizontalPadding;
  final Color? backgroundColor;
  final List<Widget> children;
  final List<String> labels;
  final double? tabBarHeight;
  final bool useAspectRatioToSolveLayout;
  final double aspectRatio;

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.labels.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.useAspectRatioToSolveLayout
        ? AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 16, horizontal: widget.tabBarHorizontalPadding),
                  child: Container(
                    height: widget.tabBarHeight,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ??
                          Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    child: Theme(
                      data: ThemeData(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: TabBar(
                        controller: tabController,
                        labelPadding: EdgeInsets.zero,
                        padding: const EdgeInsets.all(4),
                        indicator: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.black,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.w500),
                        tabs: widget.labels.map((e) => Tab(text: e)).toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: tabController, children: widget.children),
                )
              ],
            ),
          )
        : NestedScrollView(
            headerSliverBuilder: (context, val) => [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                      vertical: 16, horizontal: widget.tabBarHorizontalPadding),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: widget.tabBarHeight,
                      decoration: BoxDecoration(
                        color: widget.backgroundColor ?? Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      child: Theme(
                        data: ThemeData(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: TabBar(
                          controller: tabController,
                          labelPadding: EdgeInsets.zero,
                          padding: const EdgeInsets.all(4),
                          indicator: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          labelColor: Theme.of(context).primaryColor,
                          unselectedLabelColor: Colors.black,
                          labelStyle: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.w500),
                          tabs: widget.labels.map((e) => Tab(text: e)).toList(),
                        ),
                      ),
                    ),
                  ))
            ],
            body: TabBarView(
                controller: tabController, children: widget.children),
          );
  }
}
