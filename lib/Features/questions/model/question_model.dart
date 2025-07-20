import 'package:flutter/material.dart';

class QuestionModel {
  final String question;
  final String image;
  final String image2;
  final String title;
  final Widget widget;
  final List<int> correctIndex;
  final Widget correctDialog;
  final Widget wrongDialog;
  final List<int>? correctIndices;
  QuestionModel(
      {required this.question,
      required this.image,
      required this.image2,
      required this.title,
      required this.widget,
      required this.correctIndex,
      this.correctDialog = const SizedBox.shrink(),
      this.wrongDialog = const SizedBox.shrink(),
      this.correctIndices});
}
