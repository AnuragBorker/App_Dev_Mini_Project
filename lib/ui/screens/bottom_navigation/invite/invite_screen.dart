import 'package:fire_chat/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fire_chat/ui/widgets/button_widget.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});

  final String apkDownloadLink = "https://your-app-link-here.com/app.apk";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),

            // Header consistent with Profile/ChatList
            Text(
              "Invite Friends",
              style: h,
            ),
            SizedBox(height: 20),

            // Beta tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.amber.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "BETA",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description
            const Text(
              "Share the APK link with your friends and bring them onto FireChat! "
                  "This feature is currently in beta.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // QR Code
            Center(
              child: QrImageView(
                data: apkDownloadLink,
                size: 200.0,
                gapless: true,
              ),
            ),
            const SizedBox(height: 30),

            // Copy APK link button
            CustomButton(
              buttonText: "Copy APK Link",
              onPressed: () {
                Clipboard.setData(ClipboardData(text: apkDownloadLink));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("APK link copied to clipboard")),
                );
              },
            ),
            const SizedBox(height: 15),

            // Share APK link button
            CustomButton(
              buttonText: "Share APK Link",
              onPressed: () {
                ShareParams params = ShareParams(
                  text: "Download our FireChat App 🔥\n$apkDownloadLink",
                );
                SharePlus.instance.share(params);
              },
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
