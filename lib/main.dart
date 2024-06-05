import 'package:flutter/material.dart';


void main() {
  runApp(const MaterialApp(
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('firstScreen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'number = $_number',
            ),
            ElevatedButton(
              onPressed: () async {
                final newNumber = await Navigator.of(context).push<int>(
                  MaterialPageRoute(
                    builder: (_) => SecondScreen(number: _number,text: _controller.text,),
                  ),
                );
                setState(() {
                  if (newNumber != null) {
                    _number = newNumber;
                  }
                });
              }, 
             child: const Text('secondへ'),
            ),
            const Text('data'),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'enter'
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(number + 1);
              }, 
              child: const Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(number - 1);
              },
              child: const Text('Decrement')),
            Text(
              text,
              style: const TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}