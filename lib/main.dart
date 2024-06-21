import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _bahasaAwal = 'en';
  String _bahasaTujuan = 'id';
  final TextEditingController _bahasaAwalController = TextEditingController();
  final TextEditingController _bahasaTujuanController = TextEditingController();

  @override
  void dispose() {
    _bahasaAwalController.dispose();
    _bahasaTujuanController.dispose();
    super.dispose();
  }

  Future<void> terjemahkan(
      {required String konten,
      required String dariBahasa,
      required String keBahasa}) async {
    final GoogleTranslator translator = GoogleTranslator();
    Translation terjemahan =
        await translator.translate(konten, from: dariBahasa, to: keBahasa);
    setState(() {
      _bahasaTujuanController.text = '''${terjemahan.toString()} \n''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translator"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _bahasaAwalController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text("Indonesia"),
                      value: 'id',
                    ),
                    DropdownMenuItem(
                      child: Text("English"),
                      value: 'en',
                    ),
                  ],
                  value: _bahasaAwal,
                  onChanged: (value) {
                    setState(() {
                      _bahasaAwal = value.toString();
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      terjemahkan(
                          konten: _bahasaAwalController.text,
                          dariBahasa: _bahasaAwal,
                          keBahasa: _bahasaTujuan);
                    },
                    child: const Text("Translate")),
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text("Indonesia"),
                      value: 'id',
                    ),
                    DropdownMenuItem(
                      child: Text("English"),
                      value: 'en',
                    ),
                  ],
                  value: _bahasaTujuan,
                  onChanged: (value) {
                    setState(() {
                      _bahasaTujuan = value.toString();
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(children: [
                TextField(
                  maxLines: 15,
                  controller: _bahasaTujuanController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              print("kopi data");
                            },
                            icon: const Icon(Icons.copy)),
                        IconButton(
                            onPressed: () {
                              print("share data");
                            },
                            icon: const Icon(Icons.share)),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
