import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Widget buildClickableText(String content) {
  // Use a regular expression to find URLs in the content
  final regex = RegExp(r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');
  List<InlineSpan> spans = [];

  // Find all matches in the content
  final matches = regex.allMatches(content);

  int currentIndex = 0;

  for (final match in matches) {
    // Add the text before the URL
    spans.add(TextSpan(text: content.substring(currentIndex, match.start)));

    // Add the clickable URL
    spans.add(
      TextSpan(
        text: match.group(0),
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launchUrl(match.group(0)! as Uri);
          },
      ),
    );

    currentIndex = match.end;
  }

  // Add the remaining text after the last URL
  spans.add(TextSpan(text: content.substring(currentIndex)));

  return RichText(text: TextSpan(children: spans));
}
