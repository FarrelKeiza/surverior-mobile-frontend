import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';

class QuestionTypeMultipleChoice extends HookWidget {
  const QuestionTypeMultipleChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.radio_button_checked),
            const SizedBox(width: 12),
            Text("Pilihan Ganda", style: secondaryTextStyle),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.radio_button_checked),
            const SizedBox(width: 12),
            Text("Pilihan Ganda", style: secondaryTextStyle),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
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
      ],
    );
  }
}

class QuestionTypeCheckbox extends HookWidget {
  const QuestionTypeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.check_box),
            const SizedBox(width: 12),
            Text("Daftar Centang", style: secondaryTextStyle),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.check_box),
            const SizedBox(width: 12),
            Text("Daftar Centang", style: secondaryTextStyle),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
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
      ],
    );
  }
}

class QuestionTypeMultipleChoiceGrid extends HookWidget {
  const QuestionTypeMultipleChoiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: const Text(
              'Baris 1',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: const Text(
              'Baris 2',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: const Text(
              'Tambahkan Baris',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Kolom',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: const Text(
              'Kolom 1',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: const Text(
              'Kolom 2',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: const Text(
              'Tambahkan Kolom',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionTypeText extends HookWidget {
  const QuestionTypeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
              ),
            ),
          ),
          child: const Text('Isi teks', style: TextStyle(fontSize: 16)),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.format_bold),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.format_underline),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.format_strikethrough),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.format_italic),
            ),
          ],
        )
      ],
    );
  }
}

class QuestionTypeImage extends HookWidget {
  const QuestionTypeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(153, 153, 153, 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      width: double.infinity,
      height: 180,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image,
              color: Colors.white,
              size: 60,
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
