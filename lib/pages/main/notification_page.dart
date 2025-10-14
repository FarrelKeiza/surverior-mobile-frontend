import 'package:flutter/material.dart';
import 'package:surverior_frontend_mobile/utils/theme_util.dart';
import 'package:surverior_frontend_mobile/widgets/notification_card_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: gradientWidgetColorMask(
          Text(
            "Notifikasi",
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          physics: const BouncingScrollPhysics(),
          child: const Column(
            children: [
              NotificationCardWidget(
                title: "Judul Notifikasi",
                body:
                    "Poin sebanyak 320 berhasil ditambahkan dari kuesioner “Survey Perilaku Mahasiswa Informatika terhadap Perubahan Teknologi”",
                isRead: false,
              ),
              NotificationCardWidget(
                title: "Judul Notifikasi",
                body: "Poin sebanyak 320 berhasil ditambahkan",
                isRead: true,
              ),
              NotificationCardWidget(
                title: "Judul Notifikasi",
                body: "Poin sebanyak 1084 berhasil ditambahkan",
                isRead: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
