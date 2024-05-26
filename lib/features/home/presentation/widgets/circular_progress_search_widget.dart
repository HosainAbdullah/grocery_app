import 'package:flutter/material.dart';
import 'package:grocery_app/core/widgets/components/circular_progress_loading.dart';

class CircularProgressSearchWidget extends StatelessWidget {
  const CircularProgressSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffF1F1F5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const CircularProgressLoading(),
    );
  }
}
