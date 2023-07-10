import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:login/core/keys/asset_path.dart';
import 'package:login/core/keys/default_strings.dart';
import 'package:login/core/utils/styles/colors.dart';

enum SearchState {
  initial,
  loading,
  error,
}

class Search extends StatefulWidget {
  final SearchState? state;
  final List list;
  const Search({
    super.key,
    this.state = SearchState.initial,
    required this.list,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.clear();
  }

  sufixBorderColor() {
    switch (widget.state) {
      case SearchState.initial:
        return CustomPalette.black45;
      case SearchState.error:
        return CustomPalette.errorRed;
      default:
        return CustomPalette.black45;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GFSearchBar(
      searchBoxInputDecoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: CustomPalette.black45,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: CustomPalette.black45,
          ),
        ),
        prefixIcon: SizedBox(
          width: 0,
          height: 16,
          child: Center(
            child: SvgPicture.asset(
              AssetPath.search,
            ),
          ),
        ),
        suffixIcon: widget.state == SearchState.loading
            ? const CupertinoActivityIndicator()
            : SizedBox(
                width: 0,
                height: 16,
                child: Center(
                  child: SvgPicture.asset(
                    AssetPath.multiplyCircle,
                    theme: SvgTheme(currentColor: sufixBorderColor()),
                  ),
                ),
              ),
        hintText: DefaultStrings.search,
      ),
      searchList: widget.list,
      searchQueryBuilder: (query, list) {
        return widget.list
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      overlaySearchListItemBuilder: (item) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            item,
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
      onItemSelected: (item) {
        setState(() {
          //TODO(Alex): write search logic
        });
      },
    );
  }
}
