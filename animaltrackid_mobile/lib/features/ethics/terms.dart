import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../reusables/custom_appbar.dart';
import '../../utils/constants/fonts.dart';
import '../../utils/constants/colors.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  TermsScreenState createState() => TermsScreenState();
}

class TermsScreenState extends State<TermsScreen> {
  String _markdownContent = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdown();
  }

  Future<void> _loadMarkdown() async {
    final String content =
        await rootBundle.loadString('assets/ethics/terms.md');
    setState(() {
      _markdownContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnTextAppBar(
        onBackPressed: () {
          Navigator.pushReplacementNamed(context, '/signup');
        },
        title: "Terms & Conditions",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Markdown(
          data: _markdownContent,
          styleSheet: MarkdownStyleSheet(
            p: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.body,
              fontWeight: FontConstants.regular,
              color: AppColors.textColor,
            ),
            h1: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.title,
              fontWeight: FontConstants.bold,
              color: AppColors.primaryColor,
            ),
            h2: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.medium,
              fontWeight: FontConstants.bold,
              color: AppColors.splashColor,
            ),
          ),
        ),
      ),
    );
  }
}
