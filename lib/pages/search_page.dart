import 'package:flutter/material.dart';
import './map_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      Navigator.pop(context, _city!.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'City Name',
                  hintText: 'More than 2 characters',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
                validator: (String? input) {
                  if (input == null || input.trim().length < 2) {
                    return 'City name must be at least 2 characters long';
                  }
                  return null;
                },
                onSaved: (String? input) {
                  _city = input;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text(
                'How`s the weather',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
