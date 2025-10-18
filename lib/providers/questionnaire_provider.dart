import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/models/category.dart' as cat;
import 'package:surverior_frontend_mobile/models/questionnaire_model.dart';
import 'package:surverior_frontend_mobile/services/questionnaire_service.dart';

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
  final _questionnaireService = QuestionnaireService();

  // Questionnaire fetch state
  QuestionnaireResponseModel? _questionnaireResponse;
  bool _isLoadingQuestionnaires = false;
  String _questionnaireError = '';

  // Pagination
  int _currentPageData = 1;
  String? _currentCategory;
  String? _currentSearch;

  // Selected category for filtering
  String? _selectedCategoryName;

  // Page navigation
  int _currentPage = 1;
  int _maxPage = 1;
  final Map<int, List<CreateModel>> _pageQuestions = {};

  // Metadata persistence
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetRespondentController =
      TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  cat.Category? _selectedCategory;

  // Questionnaire fetch getters
  QuestionnaireResponseModel? get questionnaireResponse =>
      _questionnaireResponse;

  bool get isLoadingQuestionnaires => _isLoadingQuestionnaires;

  String get questionnaireError => _questionnaireError;

  List<QuestionnaireModel> get questionnaires =>
      _questionnaireResponse?.data?.questionnaires ?? [];

  QuestionnaireMetaData? get questionnaireMeta =>
      _questionnaireResponse?.data?.meta;

  int get currentPageData => _currentPageData;

  String? get selectedCategoryName => _selectedCategoryName;

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

  cat.Category? get selectedCategory => _selectedCategory;

  // NEW: total questions across all pages
  int get totalQuestions =>
      _pageQuestions.values.fold<int>(0, (sum, list) => sum + list.length);

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
  void setSelectedCategory(cat.Category? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Questionnaire fetch methods
  void setLoadingQuestionnaires(bool value) {
    _isLoadingQuestionnaires = value;
    notifyListeners();
  }

  void setQuestionnaireError(String error) {
    _questionnaireError = error;
    notifyListeners();
  }

  void clearQuestionnaireError() {
    _questionnaireError = '';
    notifyListeners();
  }

  // Method untuk fetch questionnaires
  Future<bool> fetchQuestionnaires({
    int page = 1,
    int perPage = 10,
    String? category,
    String? search,
    bool append = false,
  }) async {
    if (!append) {
      setLoadingQuestionnaires(true);
    }
    clearQuestionnaireError();

    try {
      final data = await _questionnaireService.getQuestionnaires(
        page: page,
        perPage: perPage,
        category: category,
        search: search,
      );

      if (append && _questionnaireResponse != null) {
        // Append new questionnaires to existing list
        final existingQuestionnaires =
            _questionnaireResponse!.data?.questionnaires ?? [];
        final newQuestionnaires = data.data?.questionnaires ?? [];
        data.data?.questionnaires = [
          ...existingQuestionnaires,
          ...newQuestionnaires
        ];
      }

      _questionnaireResponse = data;
      _currentPageData = page;
      _currentCategory = category;
      _currentSearch = search;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Questionnaires Response received");
        print("Metadata code: ${_questionnaireResponse?.metadata?.code}");
        print(
            "Total questionnaires: ${_questionnaireResponse?.data?.questionnaires?.length}");
        print(
            "Current page: ${_questionnaireResponse?.data?.meta?.currentPage}");
        print("Total pages: ${_questionnaireResponse?.data?.meta?.lastPage}");
      }

      if (_questionnaireResponse?.metadata?.code == 200) {
        setLoadingQuestionnaires(false);
        return true;
      } else {
        setLoadingQuestionnaires(false);
        setQuestionnaireError(_questionnaireResponse?.metadata?.message ??
            'Failed to fetch questionnaires');
        return false;
      }
    } catch (e) {
      setLoadingQuestionnaires(false);
      setQuestionnaireError(e.toString());
      if (kDebugMode) {
        print("Fetch Questionnaires Error: $e");
      }
      return false;
    }
  }

  // Method untuk load more questionnaires (pagination)
  Future<bool> loadMoreQuestionnaires() async {
    if (_questionnaireResponse?.data?.meta?.currentPage != null &&
        _questionnaireResponse?.data?.meta?.lastPage != null) {
      int currentPage = _questionnaireResponse!.data!.meta!.currentPage!;
      int lastPage = _questionnaireResponse!.data!.meta!.lastPage!;

      if (currentPage < lastPage) {
        return await fetchQuestionnaires(
          page: currentPage + 1,
          category: _currentCategory,
          search: _currentSearch,
          append: true,
        );
      }
    }
    return false;
  }

  // Method untuk refresh questionnaires
  Future<bool> refreshQuestionnaires() async {
    return await fetchQuestionnaires(
      page: 1,
      category: _currentCategory,
      search: _currentSearch,
    );
  }

  // Method untuk search questionnaires
  Future<bool> searchQuestionnaires(String search) async {
    return await fetchQuestionnaires(
      page: 1,
      search: search,
      category: _currentCategory,
    );
  }

  // Method untuk filter by category
  Future<bool> filterQuestionnairesByCategory(String category) async {
    return await fetchQuestionnaires(
      page: 1,
      category: category,
      search: _currentSearch,
    );
  }

  // Method untuk fetch questionnaires by category name
  Future<bool> fetchQuestionnairesByCategory({
    String? categoryName,
    int page = 1,
    int perPage = 10,
    String? search,
    bool append = false,
  }) async {
    if (!append) {
      setLoadingQuestionnaires(true);
    }
    clearQuestionnaireError();

    try {
      final data = await _questionnaireService.getQuestionnairesByCategory(
        categoryName: categoryName,
        page: page,
        perPage: perPage,
        search: search,
      );

      if (append && _questionnaireResponse != null) {
        // Append new questionnaires to existing list
        final existingQuestionnaires =
            _questionnaireResponse!.data?.questionnaires ?? [];
        final newQuestionnaires = data.data?.questionnaires ?? [];
        data.data?.questionnaires = [
          ...existingQuestionnaires,
          ...newQuestionnaires
        ];
      }

      _questionnaireResponse = data;
      _currentPageData = page;
      _selectedCategoryName = categoryName;

      // Debug print untuk melihat response
      if (kDebugMode) {
        print("Questionnaires by Category Response received");
        print("Category: $categoryName");
        print("Metadata code: ${_questionnaireResponse?.metadata?.code}");
        print(
            "Total questionnaires: ${_questionnaireResponse?.data?.questionnaires?.length}");
        print(
            "Current page: ${_questionnaireResponse?.data?.meta?.currentPage}");
        print("Total pages: ${_questionnaireResponse?.data?.meta?.lastPage}");
      }

      if (_questionnaireResponse?.metadata?.code == 200) {
        setLoadingQuestionnaires(false);
        return true;
      } else {
        setLoadingQuestionnaires(false);
        setQuestionnaireError(_questionnaireResponse?.metadata?.message ??
            'Failed to fetch questionnaires by category');
        return false;
      }
    } catch (e) {
      setLoadingQuestionnaires(false);
      setQuestionnaireError(e.toString());
      if (kDebugMode) {
        print("Fetch Questionnaires by Category Error: $e");
      }
      return false;
    }
  }

  // Method untuk set selected category name
  void setSelectedCategoryName(String? categoryName) {
    _selectedCategoryName = categoryName;
    notifyListeners();
  }

  // Method untuk clear selected category
  void clearSelectedCategory() {
    _selectedCategoryName = null;
    notifyListeners();
  }

  // Method untuk clear questionnaire data
  void clearQuestionnaireData() {
    _questionnaireResponse = null;
    _questionnaireError = '';
    _isLoadingQuestionnaires = false;
    _currentPageData = 1;
    _currentCategory = null;
    _currentSearch = null;
    _selectedCategoryName = null;
    notifyListeners();
  }

  // Helper methods
  bool get hasMoreQuestionnaires {
    if (_questionnaireResponse?.data?.meta?.currentPage != null &&
        _questionnaireResponse?.data?.meta?.lastPage != null) {
      return _questionnaireResponse!.data!.meta!.currentPage! <
          _questionnaireResponse!.data!.meta!.lastPage!;
    }
    return false;
  }

  bool get hasQuestionnaires => questionnaires.isNotEmpty;

  // Method untuk get questionnaire by id dari list yang sudah di-fetch
  QuestionnaireModel? getQuestionnaireById(String id) {
    try {
      return questionnaires.firstWhere((q) => q.id == id);
    } catch (e) {
      return null;
    }
  }

  // Helper methods untuk category
  List<QuestionnaireCategory> get uniqueCategories {
    final Set<String> seenIds = <String>{};
    final List<QuestionnaireCategory> categories = [];

    for (final questionnaire in questionnaires) {
      if (questionnaire.category != null &&
          questionnaire.category!.id != null &&
          !seenIds.contains(questionnaire.category!.id)) {
        seenIds.add(questionnaire.category!.id!);
        categories.add(questionnaire.category!);
      }
    }

    return categories;
  }

  List<QuestionnaireModel> getQuestionnairesByCategory(String categoryId) {
    return questionnaires.where((q) => q.categoryId == categoryId).toList();
  }

  List<QuestionnaireModel> getQuestionnairesByCategoryName(
      String categoryName) {
    return questionnaires
        .where((q) =>
            q.category?.name?.toLowerCase() == categoryName.toLowerCase())
        .toList();
  }

  // Helper methods untuk user data
  List<QuestionnaireModel> getQuestionnairesByUser(String userId) {
    return questionnaires.where((q) => q.userId == userId).toList();
  }

  List<QuestionnaireModel> getQuestionnairesByUserName(String userName) {
    return questionnaires
        .where((q) =>
            q.user?.name?.toLowerCase().contains(userName.toLowerCase()) ??
            false)
        .toList();
  }

  String getUserName(QuestionnaireModel questionnaire) {
    return questionnaire.user?.name ?? 'Unknown User';
  }

  String getUserEmail(QuestionnaireModel questionnaire) {
    return questionnaire.user?.email ?? 'No Email';
  }

  bool isUserVerified(QuestionnaireModel questionnaire) {
    return questionnaire.user?.emailVerifiedAt != null;
  }

  // Helper methods untuk analisis data
  List<String> get uniqueUsers {
    final Set<String> seenUserIds = <String>{};
    final List<String> userNames = [];

    for (final questionnaire in questionnaires) {
      if (questionnaire.user?.id != null &&
          !seenUserIds.contains(questionnaire.user!.id)) {
        seenUserIds.add(questionnaire.user!.id!);
        userNames.add(questionnaire.user?.name ?? 'Unknown User');
      }
    }

    return userNames;
  }

  Map<String, int> get questionnaireCountByUser {
    final Map<String, int> userCounts = {};

    for (final questionnaire in questionnaires) {
      final userName = questionnaire.user?.name ?? 'Unknown User';
      userCounts[userName] = (userCounts[userName] ?? 0) + 1;
    }

    return userCounts;
  }

  Map<String, int> get questionnaireCountByCategory {
    final Map<String, int> categoryCounts = {};

    for (final questionnaire in questionnaires) {
      final categoryName = questionnaire.category?.name ?? 'No Category';
      categoryCounts[categoryName] = (categoryCounts[categoryName] ?? 0) + 1;
    }

    return categoryCounts;
  }

  // Helper methods untuk statistics
  double get averageCost {
    if (questionnaires.isEmpty) return 0.0;

    double totalCost = 0.0;
    int validCosts = 0;

    for (final questionnaire in questionnaires) {
      if (questionnaire.cost != null) {
        totalCost += questionnaire.cost!;
        validCosts++;
      }
    }

    return validCosts > 0 ? totalCost / validCosts : 0.0;
  }

  double get averageReward {
    if (questionnaires.isEmpty) return 0.0;

    double totalReward = 0.0;
    int validRewards = 0;

    for (final questionnaire in questionnaires) {
      if (questionnaire.reward != null) {
        totalReward += questionnaire.reward!;
        validRewards++;
      }
    }

    return validRewards > 0 ? totalReward / validRewards : 0.0;
  }

  double get averageRespondentTarget {
    if (questionnaires.isEmpty) return 0.0;

    double totalTarget = 0.0;
    int validTargets = 0;

    for (final questionnaire in questionnaires) {
      if (questionnaire.respondentTarget != null) {
        totalTarget += questionnaire.respondentTarget!.toDouble();
        validTargets++;
      }
    }

    return validTargets > 0 ? totalTarget / validTargets : 0.0;
  }

  // Helper methods untuk formatting data
  String getFormattedCost(QuestionnaireModel questionnaire) {
    if (questionnaire.cost == null) return 'Gratis';

    String formatted = questionnaire.cost!.toStringAsFixed(0);
    String result = '';
    int count = 0;

    for (int i = formatted.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = '.$result';
      }
      result = formatted[i] + result;
      count++;
    }

    return 'Rp $result';
  }

  String getFormattedReward(QuestionnaireModel questionnaire) {
    if (questionnaire.reward == null) return 'Rp 0';

    String formatted = questionnaire.reward!.toStringAsFixed(0);
    String result = '';
    int count = 0;

    for (int i = formatted.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = '.$result';
      }
      result = formatted[i] + result;
      count++;
    }

    return 'Rp $result';
  }

  String getFormattedDeadline(QuestionnaireModel questionnaire) {
    if (questionnaire.deadline == null) return 'Tidak ada deadline';

    try {
      DateTime date = DateTime.parse(questionnaire.deadline!);
      List<String> months = [
        '',
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];

      return '${date.day} ${months[date.month]} ${date.year}';
    } catch (e) {
      return questionnaire.deadline ?? 'Tidak ada deadline';
    }
  }

  // Method untuk check deadline status
  bool isDeadlinePassed(QuestionnaireModel questionnaire) {
    if (questionnaire.deadline == null) return false;

    try {
      DateTime deadline = DateTime.parse(questionnaire.deadline!);
      return DateTime.now().isAfter(deadline);
    } catch (e) {
      return false;
    }
  }

  int getDaysUntilDeadline(QuestionnaireModel questionnaire) {
    if (questionnaire.deadline == null) return -1;

    try {
      DateTime deadline = DateTime.parse(questionnaire.deadline!);
      Duration difference = deadline.difference(DateTime.now());
      return difference.inDays;
    } catch (e) {
      return -1;
    }
  }

  // NEW: Questionnaire creation state
  bool _isCreatingQuestionnaire = false;

  // NEW: Getter for questionnaire creation state
  bool get isCreatingQuestionnaire => _isCreatingQuestionnaire;

  // Helper method to map question types
  String _mapQuestionType(int type) {
    switch (type) {
      case 0:
        return 'multiple_choice';
      case 1:
        return 'checkbox';
      case 2:
        return 'short_answer';
      case 3:
        return 'paragraph';
      case 4:
        return 'grid';
      case 5:
        return 'text';
      case 6:
        return 'image';
      default:
        return 'multiple_choice';
    }
  }

  // Helper method to generate URL slug
  String _generateUrlSlug(String title) {
    return title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  // Implement questionnaire creation
  Future<void> createQuestionnaire() async {
    try {
      _isCreatingQuestionnaire = true;
      notifyListeners();

      // Validate required fields
      if (_titleController.text.trim().isEmpty ||
          _descriptionController.text.trim().isEmpty ||
          _targetRespondentController.text.trim().isEmpty ||
          _deadlineController.text.trim().isEmpty ||
          _selectedCategory == null) {
        throw Exception('Please fill in all required fields');
      }

      final int respondentTarget =
          int.tryParse(_targetRespondentController.text.trim()) ?? 0;
      if (respondentTarget <= 0) {
        throw Exception('Please enter a valid number of respondents');
      }

      // Validate that there are questions
      if (_pageQuestions.isEmpty) {
        throw Exception(
            'Please add at least one question to the questionnaire');
      }

      // Validate all question texts are not empty
      for (var pageEntry in _pageQuestions.entries) {
        final pageNumber = pageEntry.key;
        final questions = pageEntry.value;

        for (int i = 0; i < questions.length; i++) {
          final questionText = questions[i].questionControllers.text.trim();
          if (questionText.isEmpty) {
            throw Exception(
                'Question ${i + 1} on page $pageNumber cannot be empty. Please fill in all question texts.');
          }
        }
      }

      // Calculate cost using the formula: Harga = (R × 100) + (S × R × 100)
      final int totalQuestions = this.totalQuestions;
      final int cost =
          (respondentTarget * 100) + (totalQuestions * respondentTarget * 100);
      final int reward = (cost * 0.2).round(); // 20% of cost as reward

      // Generate URL slug
      final String urlSlug = _generateUrlSlug(_titleController.text.trim());
      final String url = 'https://surverior.app/surveys/$urlSlug';

      // Prepare contents array with text content only
      List<Map<String, dynamic>> contents = [];

      // Prepare questions array
      List<Map<String, dynamic>> questions = [];
      int questionOrder = 1;

      for (var pageQuestions in _pageQuestions.values) {
        for (var question in pageQuestions) {
          final questionText = question.questionControllers.text.trim();

          // Double-check question text is not empty (should be caught above)
          if (questionText.isEmpty) {
            throw Exception('Found empty question text during processing');
          }

          if (question.type == 5) {
            // Text content question
            contents.add({
              "content_type": "text",
              "content_body": question.options.textContent,
              "order": questionOrder++,
            });
            continue; // Skip adding to questions array
          }

          Map<String, dynamic> questionData = {
            "question_text": questionText,
            "question_type": _mapQuestionType(question.type),
            "is_required": true,
            "order": questionOrder++,
          };

          // Add options for question types that have them
          List<Map<String, dynamic>> options = [];
          switch (question.type) {
            case 0: // Multiple choice
              for (int i = 0;
                  i < question.options.multipleChoiceOptions.length;
                  i++) {
                options.add({
                  "option_text": question.options.multipleChoiceOptions[i],
                  "value": question.options.multipleChoiceOptions[i]
                      .toLowerCase()
                      .replaceAll(' ', '_'),
                  "column_label": "Choice",
                  "row_label": "Option",
                  "order": i + 1,
                });
              }
              break;
            case 1: // Checkbox
              for (int i = 0;
                  i < question.options.checkboxOptions.length;
                  i++) {
                options.add({
                  "option_text": question.options.checkboxOptions[i],
                  "value": question.options.checkboxOptions[i]
                      .toLowerCase()
                      .replaceAll(' ', '_'),
                  "column_label": "Selection",
                  "row_label": "Option",
                  "order": i + 1,
                });
              }
              break;
            case 4: // Grid
              int optionOrder = 1;
              for (var row in question.options.gridRows) {
                for (var col in question.options.gridCols) {
                  options.add({
                    "row_label": row,
                    "column_label": col,
                    "value":
                        "${row.toLowerCase().replaceAll(' ', '_')}_${col.toLowerCase().replaceAll(' ', '_')}",
                    "order": optionOrder++,
                  });
                }
              }
              break;
          }

          if (options.isNotEmpty) {
            questionData["options"] = options;
          }

          questions.add(questionData);
        }
      }

      // Add section break content after questions if there are multiple pages
      // if (_pageQuestions.length > 1) {
      //   contents.add({
      //     "content_type": "text",
      //     "content_body": "Terima kasih telah mengisi kuesioner ini. Data Anda sangat berharga bagi penelitian kami.",
      //     "order": questionOrder,
      //   });
      // }

      // Call the API
      await _questionnaireService.createQuestionnaire(
        categoryName: _selectedCategory!.name ?? '',
        topic: _titleController.text.trim(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        respondentTarget: respondentTarget,
        deadline: _deadlineController.text.trim(),
        cost: cost,
        reward: reward,
        isPublished: true,
        url: url,
        profiles: null,
        contents: contents,
        questions: questions,
      );

      // Success - questionnaire created
      clearQuestionnaireData(); // Clear data after successful creation
    } catch (e) {
      debugPrint("Error creating questionnaire: $e");
      rethrow;
    } finally {
      _isCreatingQuestionnaire = false;
      notifyListeners();
    }
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
