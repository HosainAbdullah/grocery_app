import 'package:flutter/material.dart';
import 'package:grocery_app/core/widgets/app_bar/app_bar.dart';
import 'package:grocery_app/core/widgets/text_field/search_text_field.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
          title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SearchTextField(
          hint: "Search Data Text ..",
          readOnly: true,
        ),
      )),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;

  const CategoryItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: isSelected
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).cardColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor.withOpacity(0.05)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  '$icon',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context)
                            .bottomNavigationBarTheme
                            .unselectedItemColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
