import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:InventoryWise/utils/app_theme.dart';

import '../utils/app_constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.title,
      this.actions,
      this.leading,
      this.centerTitle,
      this.backgroundColor = Colors.white,
      this.elevation,
      this.statusBarIconBrightness,
      this.searchMode = false,
      this.onSearchChanged,
      this.onCancelSearchTap})
      : super(key: key);

  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool searchMode;
  final Brightness? statusBarIconBrightness;
  final void Function()? onCancelSearchTap;
  final void Function(String)? onSearchChanged;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController searchController = TextEditingController();
  late bool _searchMode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchMode = widget.searchMode;
  }

  @override
  void didUpdateWidget(covariant CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _searchMode = widget.searchMode;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      iconTheme: IconThemeData(
          color: widget.backgroundColor == Colors.white
              ? Colors.black
              : Colors.white),
      titleTextStyle: TextStyle(
          color: widget.backgroundColor == Colors.white
              ? Colors.black
              : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500),
      systemOverlayStyle: SystemUiOverlayStyle(
        // // statusBarColor: backgroundColor ?? Colors.white,

        //jd
        statusBarIconBrightness: widget.statusBarIconBrightness,
        // systemNavigationBarIconBrightness:
        //     backgroundColor == Colors.white ? Brightness.dark : null,
      ),

      // toolbarTextStyle: TextStyle(fontFamily: 'JosefinSans'),
      elevation: widget.elevation,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(15),
      //   ),
      // ),
      actions: _searchMode
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    if (widget.onCancelSearchTap != null) {
                      widget.onCancelSearchTap!();
                    }
                    searchController.clear();
                  },
                  child: const Text('Cancel'),
                ),
              )
            ]
          : widget.actions,
      leading: _searchMode ? const Icon(Icons.search) : widget.leading,
      centerTitle: widget.centerTitle,
      title: _searchMode == true && widget.title is! TextField
          ? TextField(
              controller: searchController,
              onChanged: (val) {
                if (val.length >= AppConstants.searchLength) {
                  widget.onSearchChanged!(val);
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search brands, stores etc.',
              ),
              style: TextStyle(color: AppTheme.secondaryTextColor),
            )
          : widget.title,
    );
  }
}
