import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serious_game/Features/questions/model/question_model.dart';
import 'package:serious_game/core/apis/api.dart';

class QuestionaireController extends GetxController {
  QuestionaireController();

  RxString currentStepImage = "assets/images/land2.png".obs;
  RxInt score = 0.obs;
  final Map<int, String> overriddenImages = {};

  final List<ContainerModel> containers = [
    ContainerModel(
        index: 1, imagePath: "assets/images/container1.png", left: 220, top: 0),
    ContainerModel(
        index: 2, imagePath: "assets/images/container2.png", left: 40, top: 50),
    ContainerModel(
        index: 3,
        imagePath: "assets/images/container3.png",
        right: 25,
        top: 70),
    ContainerModel(
      index: 4,
      imagePath: "assets/images/container4.png",
      right: 200,
      bottom: 160,
    ),
    ContainerModel(
        index: 5,
        imagePath: "assets/images/container5.png",
        right: 130,
        top: 5),
    ContainerModel(
        index: 6,
        imagePath: "assets/images/container6.png",
        left: 80,
        bottom: 60),
  ];

  RxInt currentPage = 0.obs;

  void calculateScore(List<List<QuestionModel>> questionsPerPage) {
    double points = 0;
    int totalQuestions = 12;

    int questionCount = 0;

    for (int pageIndex = 0; pageIndex < questionsPerPage.length; pageIndex++) {
      for (int questionIndex = 0;
          questionIndex < questionsPerPage[pageIndex].length;
          questionIndex++) {
        if (questionCount == 11) {
          questionCount++;
          continue; // skip question 12
        }

        final question = questionsPerPage[pageIndex][questionIndex];
        final userAnswers = selectedAnswers[questionIndex];

        final listEquality = const ListEquality<int>();
        bool isCorrect = false;

        if (question.correctIndices != null) {
          isCorrect =
              listEquality.equals(userAnswers, question.correctIndices!);
        } else {
          isCorrect = listEquality.equals(
            userAnswers.toSet().toList()..sort(),
            question.correctIndex.toSet().toList()..sort(),
          );
        }

        if (isCorrect) {
          points += 1;
        }

        questionCount++;
      }
    }
    score.value = ((points / 11.0) * 20).round();
  }

  final _storage = GetStorage();

  var selectedAnswers = <List<int>>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void init(int totalQuestions) {
    selectedAnswers.value = List.generate(totalQuestions, (_) => []);
  }

  void selectAnswer(int questionIndex, int selectedIndex,
      {bool isMultiple = false}) {
    var selectedList = selectedAnswers[questionIndex];

    if (!isMultiple) {
      // For single answer questions
      selectedAnswers[questionIndex] = [selectedIndex];
    } else {
      // For multiple answer questions
      if (selectedList.contains(selectedIndex)) {
        selectedList.remove(selectedIndex); // Toggle off
      } else {
        selectedList.add(selectedIndex); // Append (order preserved)
      }
      selectedAnswers[questionIndex] =
          List.from(selectedList); // Trigger update
    }

    // 🔁 Update the image based on selected answer
    switch (selectedIndex) {
      case 0:
        currentStepImage.value = "assets/images/pos1.png";
        break;
      case 1:
        currentStepImage.value = "assets/images/pos2.png";
        break;
      case 2:
        currentStepImage.value = "assets/images/pos3.png";
        break;
      case 3:
        currentStepImage.value = "assets/images/pos4.png";
        break;
      case 4:
        currentStepImage.value = "assets/images/pos5.png";
        break;
      default:
        currentStepImage.value = "assets/images/land2.png";
    }
  }

  Map<int, Map<int, int>> selectionOrders = {};

  void toggleAnswerWithOrder(int questionIndex, int selectedIndex) {
    var selectedList = selectedAnswers[questionIndex];
    selectionOrders.putIfAbsent(questionIndex, () => {});

    if (selectedList.contains(selectedIndex)) {
      // Remove and reassign order
      selectedList.remove(selectedIndex);
      selectionOrders[questionIndex]!.remove(selectedIndex);

      // Also unselect the paired one if needed
      if (selectedIndex == 2 && selectedList.contains(3)) {
        selectedList.remove(3);
        selectionOrders[questionIndex]!.remove(3);
        overriddenImages.remove(3);
      }
      if (selectedIndex == 3 && selectedList.contains(2)) {
        selectedList.remove(2);
        selectionOrders[questionIndex]!.remove(2);
        overriddenImages.remove(2);
      }

      // Reassign order
      final newOrder = <int, int>{};
      for (int i = 0; i < selectedList.length; i++) {
        newOrder[selectedList[i]] = i + 1;
      }
      selectionOrders[questionIndex] = newOrder;
    } else {
      if (selectedList.length >= 4) return;

      selectedList.add(selectedIndex);
      selectionOrders[questionIndex]![selectedIndex] = selectedList.length;

      // --- Special logic for linked selections ---
      if (selectedIndex == 2 && !selectedList.contains(3)) {
        selectedList.add(3);
        selectionOrders[questionIndex]![3] = selectedList.length;
        overriddenImages[3] = "assets/images/yesa.png";
      } else if (selectedIndex == 3 && !selectedList.contains(2)) {
        selectedList.add(2);
        selectionOrders[questionIndex]![2] = selectedList.length;
        overriddenImages[2] = "assets/images/yesb.png";
      }
    }

    selectedAnswers[questionIndex] =
        List.from(selectedList); // trigger UI update
  }

  /// Utility to get selectedIndex list
  List<int> getSelectedAnswers(int questionIndex) {
    return selectedAnswers[questionIndex];
  }

  bool isStepActive(int stepNumber, int currentIndex) {
    switch (stepNumber) {
      case 1:
        return currentIndex >= 0 && currentIndex <= 3 && currentPage.value > 1;
      case 2:
        return currentIndex >= 5 && currentIndex <= 9;
      case 3:
        return currentIndex >= 10;
      case 4:
        return currentIndex >= 12;
      default:
        return false;
    }
  }

  bool isStepCompleted(int stepNumber, int currentIndex) {
    switch (stepNumber) {
      case 1:
        return currentIndex >= 4;
      case 2:
        return currentIndex >= 9;
      case 3:
        return currentIndex >= 11;
      case 4:
        return currentIndex >= 13;
      default:
        return false;
    }
  }

  void reset(int totalQuestions) {
    score.value = 0;
    currentPage.value = 0;
    currentQuestionIndex.value = 0;
    selectedAnswers.clear();
    selectionOrders.clear();
  }

  Future<void> updateUserScore(int newScore) async {
    if (_storage.read('userId') == null) {
      return;
    }

    try {
      var res =
          await ApiService.updateScore(_storage.read('userId')!, newScore);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {}
}

class ContainerModel {
  final int index;
  final String imagePath;
  final double? left, top, right, bottom;

  ContainerModel({
    required this.index,
    required this.imagePath,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });
}
