import 'package:flutter/material.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';

class SeeAllView extends StatelessWidget {
  const SeeAllView({
    super.key,
    required this.context,
    required this.name,
    required this.onTapAction,
  });

  final BuildContext context;
  final String name;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        InkResponse(
          onTap: () {
            onTapAction();
          },
          child: Text(
            StringsAllApp.seeAllText.tr(context),
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
