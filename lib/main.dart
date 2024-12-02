import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter First App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _controller = TextEditingController();

  void _incrementCounter() {
    setState(() {
      final String inputText = _controller.text;

      if (inputText == 'Avada Kedavra') {
        _counter = 0;
      } else {
        final int? inputNumber = int.tryParse(inputText);
        if (inputNumber != null) {
          _counter += inputNumber;
        }
      }

      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Interactive Input and Counter',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      extendBodyBehindAppBar: true,
      // Allows the body to extend behind the AppBar
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_harry_potter2.png'),
            // Background image from assets
            fit: BoxFit.cover, // Cover the entire background
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Current value of the counter:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Increase font size
                ),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 48, // Increase counter font size
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter a number or "Avada Kedavra"',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Increase input text size
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Update Counter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


