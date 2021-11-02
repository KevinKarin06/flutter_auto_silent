import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:autosilentflutter/view_models/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class NoLocationScreen extends ViewModelWidget<HomeViewModel> {
  const NoLocationScreen() : super(reactive: false);
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    Logger().d('Loading Screen Rebuilt');
    return Container(
      child: Center(
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              'No Locations Added Yet',
            ),
            TypewriterAnimatedText(
              'Add Locations to get Started',
            ),
          ],
        ),
      ),
    );
  }
}
