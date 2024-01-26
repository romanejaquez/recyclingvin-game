import 'package:flutter/material.dart';
import 'package:recyclingvin_web/helpers/enums.dart';

class OnboardingStepModel {
  final String title;
  final String content;
  final Color titleColor;
  final OnboardingBadgeOptions badge;

  OnboardingStepModel({
    required this.title,
    required this.content,
    required this.titleColor,
    required this.badge,
  });
}