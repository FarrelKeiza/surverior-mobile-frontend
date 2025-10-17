import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/providers/questionnaire_provider.dart';

class QuestionTypeMultipleChoice extends HookWidget {
  const QuestionTypeMultipleChoice({super.key, required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final currentQuestion = provider.currentPageQuestions[questionIndex];
    final options = currentQuestion.options.multipleChoiceOptions;

    final editingIndex = useState<int?>(null);
    final controllerState = useState<TextEditingController?>(null);

    // Dispose controller on widget unmount
    useEffect(() {
      return () {
        controllerState.value?.dispose();
        controllerState.value = null;
      };
    }, []);

    void startEditing(int idx) {
      controllerState.value?.dispose();
      controllerState.value = TextEditingController(text: options[idx]);
      editingIndex.value = idx;
    }

    void finishEditing([int? idx]) {
      final i = idx ?? editingIndex.value;
      if (i != null) {
        final newText = controllerState.value?.text ?? options[i];
        final newList = [...options];
        newList[i] = newText.isEmpty ? 'Pilihan ${i + 1}' : newText;
        provider.updateMultipleChoiceOptions(questionIndex, newList);
      }
      controllerState.value?.dispose();
      controllerState.value = null;
      editingIndex.value = null;
    }

    void addOption() {
      final newList = [...options, ''];
      provider.updateMultipleChoiceOptions(questionIndex, newList);
      final idx = newList.length - 1;
      controllerState.value?.dispose();
      controllerState.value = TextEditingController(text: '');
      editingIndex.value = idx;
    }

    void removeOption(int idx) {
      if (options.length <= 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Minimal 2 pilihan diperlukan')),
        );
        return;
      }

      final newList = [...options]..removeAt(idx);
      provider.updateMultipleChoiceOptions(questionIndex, newList);

      // Adjust editing state / controller
      if (editingIndex.value != null) {
        if (editingIndex.value == idx) {
          // removed the currently editing item
          controllerState.value?.dispose();
          controllerState.value = null;
          editingIndex.value = null;
        } else if (editingIndex.value! > idx) {
          // shift editing index down
          editingIndex.value = editingIndex.value! - 1;
        }
      }
    }

    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          Row(
            children: [
              const Icon(Icons.radio_button_checked),
              const SizedBox(width: 12),
              Expanded(
                child: editingIndex.value == i
                    ? TextField(
                        controller: controllerState.value,
                        autofocus: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          border: UnderlineInputBorder(),
                        ),
                        onSubmitted: (_) => finishEditing(i),
                        onEditingComplete: () => finishEditing(i),
                      )
                    : GestureDetector(
                        onTap: () => startEditing(i),
                        child: Text(
                          options[i].isEmpty
                              ? 'Pilihan ${i + 1}'
                              : options[i],
                          style: secondaryTextStyle,
                        ),
                      ),
              ),
              if (editingIndex.value == i)
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => finishEditing(i),
                ),
              // Delete button (disabled when only 2 items remain)
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                  ),
                  onPressed:
                      options.length > 2 ? () => removeOption(i) : null,
                  tooltip: options.length > 2
                      ? 'Hapus pilihan'
                      : 'Minimal 2 pilihan',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        GestureDetector(
          onTap: addOption,
          child: const Row(
            children: [
              Icon(
                Icons.radio_button_off,
                color: Colors.grey,
              ),
              SizedBox(width: 12),
              Text(
                "+ Tambah Pilihan",
                style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionTypeCheckbox extends HookWidget {
  const QuestionTypeCheckbox({super.key, required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final currentQuestion = provider.currentPageQuestions[questionIndex];
    final options = currentQuestion.options.checkboxOptions;

    final editingIndex = useState<int?>(null);
    final controllerState = useState<TextEditingController?>(null);

    useEffect(() {
      return () {
        controllerState.value?.dispose();
        controllerState.value = null;
      };
    }, []);

    void startEditing(int idx) {
      controllerState.value?.dispose();
      controllerState.value = TextEditingController(text: options[idx]);
      editingIndex.value = idx;
    }

    void finishEditing([int? idx]) {
      final i = idx ?? editingIndex.value;
      if (i != null) {
        final newText = controllerState.value?.text ?? options[i];
        final newList = [...options];
        newList[i] = newText.isEmpty ? 'Daftar Centang ${i + 1}' : newText;
        provider.updateCheckboxOptions(questionIndex, newList);
      }
      controllerState.value?.dispose();
      controllerState.value = null;
      editingIndex.value = null;
    }

    void addOption() {
      final newList = [...options, ''];
      provider.updateCheckboxOptions(questionIndex, newList);
      final idx = newList.length - 1;
      controllerState.value?.dispose();
      controllerState.value = TextEditingController(text: '');
      editingIndex.value = idx;
    }

    void removeOption(int idx) {
      if (options.length <= 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Minimal 2 pilihan diperlukan')),
        );
        return;
      }

      final newList = [...options]..removeAt(idx);
      provider.updateCheckboxOptions(questionIndex, newList);

      // Adjust editing state / controller
      if (editingIndex.value != null) {
        if (editingIndex.value == idx) {
          // removed the currently editing item
          controllerState.value?.dispose();
          controllerState.value = null;
          editingIndex.value = null;
        } else if (editingIndex.value! > idx) {
          // shift editing index down
          editingIndex.value = editingIndex.value! - 1;
        }
      }
    }

    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          Row(
            children: [
              const Icon(Icons.check_box),
              const SizedBox(width: 12),
              Expanded(
                child: editingIndex.value == i
                    ? TextField(
                        controller: controllerState.value,
                        autofocus: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          border: UnderlineInputBorder(),
                        ),
                        onSubmitted: (_) => finishEditing(i),
                        onEditingComplete: () => finishEditing(i),
                      )
                    : GestureDetector(
                        onTap: () => startEditing(i),
                        child: Text(
                          options[i].isEmpty
                              ? 'Daftar Centang ${i + 1}'
                              : options[i],
                          style: secondaryTextStyle,
                        ),
                      ),
              ),
              if (editingIndex.value == i)
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => finishEditing(i),
                ),
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed:
                      options.length > 2 ? () => removeOption(i) : null,
                  tooltip: options.length > 2
                      ? 'Hapus pilihan'
                      : 'Minimal 2 pilihan',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        GestureDetector(
          onTap: addOption,
          child: const Row(
            children: [
              Icon(
                Icons.check_box_outline_blank,
                color: Colors.grey,
              ),
              SizedBox(width: 12),
              Text(
                "+ Tambah Pilihan",
                style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionTypeMultipleChoiceGrid extends HookWidget {
  const QuestionTypeMultipleChoiceGrid({super.key, required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final currentQuestion = provider.currentPageQuestions[questionIndex];
    final rows = currentQuestion.options.gridRows;
    final cols = currentQuestion.options.gridCols;

    final rowEditing = useState<int?>(null);
    final colEditing = useState<int?>(null);

    final rowController = useState<TextEditingController?>(null);
    final colController = useState<TextEditingController?>(null);

    // Dispose controllers on unmount
    useEffect(() {
      return () {
        rowController.value?.dispose();
        colController.value?.dispose();
        rowController.value = null;
        colController.value = null;
      };
    }, []);

    // ROW helpers
    void startEditRow(int idx) {
      rowController.value?.dispose();
      rowController.value = TextEditingController(text: rows[idx]);
      rowEditing.value = idx;
    }

    void finishEditRow([int? idx]) {
      final i = idx ?? rowEditing.value;
      if (i != null) {
        final text = rowController.value?.text ?? rows[i];
        final newList = [...rows];
        newList[i] = text.isEmpty ? 'Baris ${i + 1}' : text;
        provider.updateGridOptions(questionIndex, rows: newList);
      }
      rowController.value?.dispose();
      rowController.value = null;
      rowEditing.value = null;
    }

    void addRow() {
      final newList = [...rows, ''];
      provider.updateGridOptions(questionIndex, rows: newList);
      final idx = newList.length - 1;
      rowController.value?.dispose();
      rowController.value = TextEditingController(text: '');
      rowEditing.value = idx;
    }

    void removeRow(int idx) {
      const minRows = 2;
      if (rows.length <= minRows) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Minimal 2 baris diperlukan')),
        );
        return;
      }
      final newList = [...rows]..removeAt(idx);
      provider.updateGridOptions(questionIndex, rows: newList);

      if (rowEditing.value != null) {
        if (rowEditing.value == idx) {
          rowController.value?.dispose();
          rowController.value = null;
          rowEditing.value = null;
        } else if (rowEditing.value! > idx) {
          rowEditing.value = rowEditing.value! - 1;
        }
      }
    }

    // COLUMN helpers
    void startEditCol(int idx) {
      colController.value?.dispose();
      colController.value = TextEditingController(text: cols[idx]);
      colEditing.value = idx;
    }

    void finishEditCol([int? idx]) {
      final i = idx ?? colEditing.value;
      if (i != null) {
        final text = colController.value?.text ?? cols[i];
        final newList = [...cols];
        newList[i] = text.isEmpty ? 'Kolom ${i + 1}' : text;
        provider.updateGridOptions(questionIndex, cols: newList);
      }
      colController.value?.dispose();
      colController.value = null;
      colEditing.value = null;
    }

    void addCol() {
      final newList = [...cols, ''];
      provider.updateGridOptions(questionIndex, cols: newList);
      final idx = newList.length - 1;
      colController.value?.dispose();
      colController.value = TextEditingController(text: '');
      colEditing.value = idx;
    }

    void removeCol(int idx) {
      const minCols = 1;
      if (cols.length <= minCols) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Minimal 1 kolom diperlukan')),
        );
        return;
      }
      final newList = [...cols]..removeAt(idx);
      provider.updateGridOptions(questionIndex, cols: newList);

      if (colEditing.value != null) {
        if (colEditing.value == idx) {
          colController.value?.dispose();
          colController.value = null;
          colEditing.value = null;
        } else if (colEditing.value! > idx) {
          colEditing.value = colEditing.value! - 1;
        }
      }
    }

    Widget itemRow({
      required IconData icon,
      required int idx,
      required bool isEditing,
      required TextEditingController? controller,
      required VoidCallback onStartEdit,
      required VoidCallback onFinishEdit,
      required VoidCallback onRemove,
      required String placeholder,
    }) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1)),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: isEditing
                  ? TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        border: UnderlineInputBorder(),
                      ),
                      onSubmitted: (_) => onFinishEdit(),
                      onEditingComplete: () => onFinishEdit(),
                    )
                  : GestureDetector(
                      onTap: onStartEdit,
                      child: Text(
                        (controller?.text.isEmpty ?? true)
                            ? placeholder
                            : (controller?.text ?? placeholder),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
            ),
            if (isEditing)
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: onFinishEdit,
              ),
            SizedBox(
              width: 36,
              height: 36,
              child: IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: onRemove,
                tooltip: 'Hapus',
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Baris',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < rows.length; i++) ...[
            itemRow(
              icon: Icons.grid_on,
              idx: i,
              isEditing: rowEditing.value == i,
              controller: rowEditing.value == i ? rowController.value : null,
              onStartEdit: () => startEditRow(i),
              onFinishEdit: () => finishEditRow(i),
              onRemove: () => removeRow(i),
              placeholder:
                  rows[i].isEmpty ? 'Baris ${i + 1}' : rows[i],
            ),
            const SizedBox(height: 3),
          ],
          TextButton(
            onPressed: addRow,
            child: const Text(
              'Tambah Baris',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Kolom',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < cols.length; i++) ...[
            itemRow(
              icon: Icons.view_column,
              idx: i,
              isEditing: colEditing.value == i,
              controller: colEditing.value == i ? colController.value : null,
              onStartEdit: () => startEditCol(i),
              onFinishEdit: () => finishEditCol(i),
              onRemove: () => removeCol(i),
              placeholder:
                  cols[i].isEmpty ? 'Kolom ${i + 1}' : cols[i],
            ),
            const SizedBox(height: 3),
          ],
          TextButton(
            onPressed: addCol,
            child: const Text(
              'Tambah Kolom',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionTypeText extends HookWidget {
  const QuestionTypeText({super.key, required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final currentQuestion = provider.currentPageQuestions[questionIndex];

    final controller = useTextEditingController(text: currentQuestion.options.textContent);

    // Listen to controller changes and update provider
    useEffect(() {
      void listener() {
        provider.updateTextContent(questionIndex, controller.text);
      }
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    // helper to wrap selection with markers
    void wrapSelection(String left, String right) {
      final sel = controller.selection;
      if (!sel.isValid) {
        final base = controller.text;
        final newText = base + left + right;
        controller.text = newText;
        controller.selection =
            TextSelection.collapsed(offset: base.length + left.length);
        return;
      }
      final text = controller.text;
      final selected = sel.textInside(text);
      final newText =
          text.replaceRange(sel.start, sel.end, '$left$selected$right');
      final newOffset =
          sel.start + left.length + selected.length + right.length;
      controller.text = newText;
      controller.selection = TextSelection.collapsed(offset: newOffset);
    }

    // parser: simple markdown-like parser for \*\*bold\*\*, \_italic\_, \~\~strike\~\~, \_\_underline\_\_
    TextSpan parsePreview(String input) {
      final List<TextSpan> spans = [];
      final pattern = RegExp(r'\*\*(.+?)\*\*|__(.+?)__|~~(.+?)~~|_(.+?)_');
      int current = 0;
      for (final match in pattern.allMatches(input)) {
        if (match.start > current) {
          spans.add(TextSpan(text: input.substring(current, match.start)));
        }
        final bold = match.group(1);
        final underline = match.group(2);
        final strike = match.group(3);
        final italic = match.group(4);

        if (bold != null) {
          spans.add(TextSpan(
              text: bold, style: const TextStyle(fontWeight: FontWeight.bold)));
        } else if (underline != null) {
          spans.add(TextSpan(
              text: underline,
              style: const TextStyle(decoration: TextDecoration.underline)));
        } else if (strike != null) {
          spans.add(TextSpan(
              text: strike,
              style: const TextStyle(decoration: TextDecoration.lineThrough)));
        } else if (italic != null) {
          spans.add(TextSpan(
              text: italic,
              style: const TextStyle(fontStyle: FontStyle.italic)));
        }
        current = match.end;
      }
      if (current < input.length) {
        spans.add(TextSpan(text: input.substring(current)));
      }
      return TextSpan(
          style: const TextStyle(fontSize: 15, color: Colors.black),
          children: spans);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1),
            ),
          ),
          child: const Text('Isi teks', style: TextStyle(fontSize: 16)),
        ),
        TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Tulis sesuatu...',
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              tooltip: 'Bold',
              onPressed: () => wrapSelection('**', '**'),
              icon: const Icon(Icons.format_bold),
            ),
            IconButton(
              tooltip: 'Underline',
              onPressed: () => wrapSelection('__', '__'),
              icon: const Icon(Icons.format_underline),
            ),
            IconButton(
              tooltip: 'Strikethrough',
              onPressed: () => wrapSelection('~~', '~~'),
              icon: const Icon(Icons.format_strikethrough),
            ),
            IconButton(
              tooltip: 'Italic',
              onPressed: () => wrapSelection('_', '_'),
              icon: const Icon(Icons.format_italic),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: RichText(
            text: parsePreview(controller.text),
          ),
        ),
      ],
    );
  }
}

class QuestionTypeImage extends HookWidget {
  const QuestionTypeImage({super.key, required this.questionIndex});

  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionnaireProvider>(context);
    final currentQuestion = provider.currentPageQuestions[questionIndex];

    final picked = useState<XFile?>(
      currentQuestion.options.imagePath != null
        ? XFile(currentQuestion.options.imagePath!)
        : null
    );
    final isLoading = useState<bool>(false);
    final picker = ImagePicker();

    Future<void> pickImage(ImageSource source) async {
      try {
        isLoading.value = true;
        final XFile? file = await picker.pickImage(
          source: source,
          maxWidth: 1600,
          imageQuality: 85,
        );

        if (file == null) {
          // User cancelled the picker — not an error
          debugPrint('pickImage: user cancelled');
          return;
        }

        // Success
        picked.value = file;
        provider.updateImagePath(questionIndex, file.path);
      } catch (e, st) {
        // Log full error so you can inspect the real cause
        debugPrint('pickImage error: $e');
        debugPrintStack(stackTrace: st);

        final message = e.toString();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memilih gambar: $message')),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    void showPickOptions() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              if (picked.value != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Hapus Gambar'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    picked.value = null;
                    provider.updateImagePath(questionIndex, null);
                  },
                ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(153, 153, 153, 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      width: double.infinity,
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (picked.value != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.file(
                File(picked.value!.path),
                fit: BoxFit.cover,
              ),
            )
          else
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 60,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: showPickOptions,
                    label: const Text('Upload Gambar'),
                    icon: const Icon(Icons.arrow_circle_up),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      overlayColor: Colors.white24,
                    ),
                  ),
                ],
              ),
            ),
          if (isLoading.value)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black26,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          Positioned(
            right: 8,
            top: 8,
            child: Row(
              children: [
                if (picked.value != null)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: showPickOptions,
                    tooltip: 'Ganti gambar',
                  ),
                if (picked.value != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      picked.value = null;
                      provider.updateImagePath(questionIndex, null);
                    },
                    tooltip: 'Hapus gambar',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
