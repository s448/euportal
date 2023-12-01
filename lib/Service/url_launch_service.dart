import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static void launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch';
    }
  }

  static void sendEmail(String? recipe, String? subject, String? body) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipe,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    final String emailUri = emailLaunchUri.toString();

    if (await canLaunchUrl(Uri.parse(emailUri))) {
      await launchUrl(Uri.parse(emailUri));
    } else {
      throw 'Could not launch email';
    }
  }
}
