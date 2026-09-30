import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() => runApp(const FastTranslationApp());

class FastTranslationApp extends StatelessWidget {
  const FastTranslationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Translation',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const TranslatorHomePage(),
    );
  }
}

class TranslatorHomePage extends StatefulWidget {
  const TranslatorHomePage({super.key});

  @override
  State<TranslatorHomePage> createState() => _TranslatorHomePageState();
}

class _TranslatorHomePageState extends State<TranslatorHomePage> {
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();
  final _translator = GoogleTranslator();
  bool _isLoading = false;

  void _translateText() async {
    if (_inputController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final translation = await _translator.translate(
        _inputController.text,
        from: 'en',
        to: 'ur',
      );
      setState(() {
        _outputController.text = translation.text;
      });
    } catch (e) {
      setState(() => _outputController.text = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fast Translation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Yahan likho',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _translateText,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Translate Karo'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _outputController,
              decoration: const InputDecoration(
                labelText: 'Translation',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
