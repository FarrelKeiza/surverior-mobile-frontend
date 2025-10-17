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

  // Method untuk clear questionnaire data
  void clearQuestionnaireData() {
    _questionnaireResponse = null;
    _questionnaireError = '';
    _isLoadingQuestionnaires = false;
    _currentPageData = 1;
    _currentCategory = null;
    _currentSearch = null;
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

  // Empty method for creating questionnaire
  Future<void> createQuestionnaire() async {}

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
