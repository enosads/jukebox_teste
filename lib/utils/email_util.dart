import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailUtil {
  static enviar(String destinatario, String text) async {
    String email = 'enosads@gmail.com';
    String password = 'ifrsfpdxrlvundgr';

    final smtpServer = gmail(email, password);

    final message = Message()
      ..from = Address(email, 'Enos Andrade')
      ..recipients.add(destinatario)
      ..subject = 'Teste Jukebox'
      ..text = text;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
