import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/models/category.dart';

class QuestionOptions {
  List<String> multipleChoiceOptions;
  List<String> checkboxOptions;
  List<String> gridRows;
  List<String> gridCols;
  String textContent;
  String? imagePath;

  QuestionOptions({
    this.multipleChoiceOptions = const ['Pilihan Ganda', 'Pilihan Ganda'],
    this.checkboxOptions = const ['Daftar Centang', 'Daftar Centang'],
    this.gridRows = const ['Baris 1', 'Baris 2'],
    this.gridCols = const ['Kolom 1'],
    this.textContent = '',
    this.imagePath,
  });

  QuestionOptions copyWith({
    List<String>? multipleChoiceOptions,
    List<String>? checkboxOptions,
    List<String>? gridRows,
    List<String>? gridCols,
    String? textContent,
    String? imagePath,
  }) {
    return QuestionOptions(
      multipleChoiceOptions:
          multipleChoiceOptions ?? this.multipleChoiceOptions,
      checkboxOptions: checkboxOptions ?? this.checkboxOptions,
      gridRows: gridRows ?? this.gridRows,
      gridCols: gridCols ?? this.gridCols,
      textContent: textContent ?? this.textContent,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

class CreateModel {
  final TextEditingController questionControllers;
  int type;
  QuestionOptions options;

  CreateModel({
    required this.questionControllers,
    this.type = 0,
    QuestionOptions? options,
  }) : options = options ?? QuestionOptions();
}

class QuestionnaireProvider with ChangeNotifier {
  // Page navigation
  int _currentPage = 1;
  int _maxPage = 1;
  Map<int, List<CreateModel>> _pageQuestions = {};

  // Metadata persistence
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetRespondentController =
      TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  Category? _selectedCategory;

  // Getters
  int get currentPage => _currentPage;

  int get maxPage => _maxPage;

  List<CreateModel> get currentPageQuestions =>
      _pageQuestions[_currentPage] ?? [];

  bool get canGoNext =>
      _currentPage < _maxPage || currentPageQuestions.isNotEmpty;

  bool get canGoPrevious => _currentPage > 1;

  // Metadata getters
  TextEditingController get titleController => _titleController;

  TextEditingController get descriptionController => _descriptionController;

  TextEditingController get targetRespondentController =>
      _targetRespondentController;

  TextEditingController get deadlineController => _deadlineController;

  Category? get selectedCategory => _selectedCategory;

  // Navigation methods
  void nextPage() {
    if (!canGoNext) return;

    if (_currentPage == _maxPage && currentPageQuestions.isNotEmpty) {
      _maxPage++;
    }
    _currentPage++;
    notifyListeners();
  }

  void previousPage() {
    if (!canGoPrevious) return;

    // If the previous page is empty, decrease max page
    if (_pageQuestions[_currentPage]?.isEmpty ?? true) {
      if (_maxPage > 1) {
        _maxPage--;
      }
    }

    _currentPage--;

    notifyListeners();
  }

  // Question management
  void addQuestion({int type = 0}) {
    if (_pageQuestions[_currentPage] == null) {
      _pageQuestions[_currentPage] = [];
    }

    _pageQuestions[_currentPage]!.add(CreateModel(
      questionControllers: TextEditingController(),
      type: type,
      options: QuestionOptions(),
    ));

    notifyListeners();
  }

  void addTextQuestion() {
    addQuestion(type: 5);
  }

  void addPhotoQuestion() {
    addQuestion(type: 6);
  }

  void removeQuestion(int questionIndex) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      _pageQuestions[_currentPage]![questionIndex]
          .questionControllers
          .dispose();
      _pageQuestions[_currentPage]!.removeAt(questionIndex);

      // If page becomes empty and it's not page 1, we might need to adjust maxPage
      if (_pageQuestions[_currentPage]!.isEmpty && _currentPage > 1) {
        _pageQuestions.remove(_currentPage);
        if (_currentPage == _maxPage) {
          _maxPage = _currentPage - 1;
          _currentPage = _maxPage;
        }
      }

      notifyListeners();
    }
  }

  // Question options management
  void updateQuestionOptions(int questionIndex, QuestionOptions newOptions) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      _pageQuestions[_currentPage]![questionIndex].options = newOptions;
      notifyListeners();
    }
  }

  void updateMultipleChoiceOptions(int questionIndex, List<String> options) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      final currentOptions =
          _pageQuestions[_currentPage]![questionIndex].options;
      _pageQuestions[_currentPage]![questionIndex].options =
          currentOptions.copyWith(
        multipleChoiceOptions: options,
      );
      notifyListeners();
    }
  }

  void updateCheckboxOptions(int questionIndex, List<String> options) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      final currentOptions =
          _pageQuestions[_currentPage]![questionIndex].options;
      _pageQuestions[_currentPage]![questionIndex].options =
          currentOptions.copyWith(
        checkboxOptions: options,
      );
      notifyListeners();
    }
  }

  void updateGridOptions(int questionIndex,
      {List<String>? rows, List<String>? cols}) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      final currentOptions =
          _pageQuestions[_currentPage]![questionIndex].options;
      _pageQuestions[_currentPage]![questionIndex].options =
          currentOptions.copyWith(
        gridRows: rows ?? currentOptions.gridRows,
        gridCols: cols ?? currentOptions.gridCols,
      );
      notifyListeners();
    }
  }

  void updateTextContent(int questionIndex, String content) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      final currentOptions =
          _pageQuestions[_currentPage]![questionIndex].options;
      _pageQuestions[_currentPage]![questionIndex].options =
          currentOptions.copyWith(
        textContent: content,
      );
      notifyListeners();
    }
  }

  void updateImagePath(int questionIndex, String? imagePath) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      final currentOptions =
          _pageQuestions[_currentPage]![questionIndex].options;
      _pageQuestions[_currentPage]![questionIndex].options =
          currentOptions.copyWith(
        imagePath: imagePath,
      );
      notifyListeners();
    }
  }

  void updateType(int questionIndex, int newType) {
    if (_pageQuestions[_currentPage] != null &&
        questionIndex < _pageQuestions[_currentPage]!.length) {
      _pageQuestions[_currentPage]![questionIndex].type = newType;
      notifyListeners();
    }
  }

  // Metadata methods
  void setSelectedCategory(Category? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Empty method for creating questionnaire
  Future<void> createQuestionnaire() async {
    // TODO: Implement questionnaire creation logic
  }

  // Cleanup
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetRespondentController.dispose();
    _deadlineController.dispose();

    // Dispose all question controllers
    for (var pageQuestions in _pageQuestions.values) {
      for (var question in pageQuestions) {
        question.questionControllers.dispose();
      }
    }

    super.dispose();
  }
}
